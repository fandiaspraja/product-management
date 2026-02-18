import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:labamu/core/network/network_info.dart';
import 'package:labamu/core/utils/exception.dart';
import 'package:labamu/core/utils/failure.dart';
import 'package:labamu/features/product/data/datasources/local/product_local_data_source.dart';
import 'package:labamu/features/product/data/datasources/remote/product_remote_data_source.dart';
import 'package:labamu/features/product/data/models/product_request.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  }) {
    // Listen for connectivity changes to trigger auto-sync
    networkInfo.onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        syncPendingChanges();
      }
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on BaseException catch (e) {
        try {
          final localProducts = await localDataSource.getProducts();
          return Right(localProducts);
        } catch (_) {
          return Left(ServerFailure(e.message));
        }
      } catch (e) {
        try {
          final localProducts = await localDataSource.getProducts();
          return Right(localProducts);
        } catch (_) {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      try {
        final localProducts = await localDataSource.getProducts();
        return Right(localProducts);
      } catch (e) {
        return Left(ConnectionFailure('Device is offline'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProductDetail(id);
        await localDataSource.cacheSingleProduct(remoteProduct);
        return Right(remoteProduct);
      } catch (e) {
        final localProduct = await localDataSource.getProductById(id);
        if (localProduct != null) return Right(localProduct);
        return Left(ServerFailure(e.toString()));
      }
    } else {
      final localProduct = await localDataSource.getProductById(id);
      if (localProduct != null) return Right(localProduct);
      return Left(
        ConnectionFailure('Device is offline and product is not cached.'),
      );
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
    ProductRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        request.status = "active";
        request.updatedAt = DateTime.now().toUtc().toIso8601String();
        final result = await remoteDataSource.createProduct(request);
        return Right(result);
      } on BaseException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // Offline Creation Logic
      try {
        // 1. Generate a Temporary ID for local display
        final tempId = 'TEMP_${DateTime.now().millisecondsSinceEpoch}';

        // 2. Create Entity
        final newProduct = ProductEntity(
          id: tempId,
          name: request.name,
          price: request.price,
          description: request.description,
          status: 'pending_sync', // Visual indicator
          updatedAt: DateTime.now().toIso8601String(),
        );

        // 3. Save to Local Cache (Optimistic UI)
        await localDataSource.cacheSingleProduct(newProduct);

        // 4. Add to Sync Queue
        await localDataSource.addQueueItem('CREATE', request.toJson());

        return Right(newProduct);
      } catch (e) {
        return Left(ServerFailure('Failed to create product offline'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
    ProductRequest request,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        request.status = "active";
        request.updatedAt = DateTime.now().toUtc().toIso8601String();
        final result = await remoteDataSource.updateProduct(request);
        return Right(result);
      } on BaseException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // Offline Update Logic
      try {
        // 1. Create Updated Entity
        // Note: In a real app, you might want to fetch the existing one first to merge fields
        final updatedProduct = ProductEntity(
          id: request.id,
          name: request.name,
          price: request.price,
          description: request.description,
          status: 'pending_sync',
          updatedAt: DateTime.now().toIso8601String(),
        );

        // 2. Update Local Cache
        await localDataSource.cacheSingleProduct(updatedProduct);

        // 3. Add to Sync Queue
        await localDataSource.addQueueItem('UPDATE', request.toJson());

        return Right(updatedProduct);
      } catch (e) {
        return Left(ServerFailure('Failed to update product offline'));
      }
    }
  }

  @override
  Future<void> syncPendingChanges() async {
    if (!await networkInfo.isConnected) return;

    final queue = await localDataSource.getQueueItems();
    for (final item in queue) {
      final id = item['id'] as int;
      final action = item['action'] as String;
      final payloadString = item['payload'] as String;
      final payload = jsonDecode(payloadString) as Map<String, dynamic>;

      try {
        if (action == 'CREATE') {
          final request = ProductRequest(
            name: payload['name'],
            price: payload['price'],
            description: payload['description'],
          );
          final result = await remoteDataSource.createProduct(request);
          // Update local cache with real data from server
          await localDataSource.cacheSingleProduct(result);
        } else if (action == 'UPDATE') {
          final request = ProductRequest(
            id: payload['id'],
            name: payload['name'],
            price: payload['price'],
            description: payload['description'],
          );
          final result = await remoteDataSource.updateProduct(request);
          await localDataSource.cacheSingleProduct(result);
        }
        await localDataSource.removeQueueItem(id);
      } catch (e) {
        // Keep in queue to retry later, or handle specific errors (like 409) here
      }
    }
  }
}
