import 'package:dio/dio.dart';
import 'package:labamu/core/network/api_client.dart';
import 'package:labamu/core/utils/exception.dart';
import 'package:labamu/core/utils/response_wrapper.dart';
import 'package:labamu/features/product/data/datasources/remote/product_remote_data_source.dart';
import 'package:labamu/features/product/data/models/product_request.dart';

import 'package:labamu/features/product/data/models/product_response.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ProductEntity> getProductDetail(String id) async {
    try {
      final response = await apiClient.get('/products/$id');

      var converted = WrappedResponse<ProductResponse>.fromJson(
        response.data,
        (data) => ProductResponse.fromJson(data),
      );

      return ProductEntity.toEntity(converted.data!);
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<ProductEntity> createProduct(ProductRequest request) async {
    try {
      final response = await apiClient.post(
        '/products',
        data: request.toJson(),
      );

      var converted = WrappedResponse<ProductResponse>.fromJson(
        response.data,
        (data) => ProductResponse.fromJson(data),
      );

      return ProductEntity.toEntity(converted.data!);
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    try {
      final response = await apiClient.get('/products');

      final converted = WrappedListResponse<ProductResponse>.fromJson(
        response.data,
        (data) => ProductResponse.fromJson(data),
      );
      return _mapProductsToEntities(converted.data);
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  List<ProductEntity> _mapProductsToEntities(List<ProductResponse> products) {
    return products.map((product) => ProductEntity.toEntity(product)).toList();
  }

  @override
  Future<ProductEntity> updateProduct(ProductRequest request) async {
    try {
      final response = await apiClient.put(
        '/products/${request.id}',
        data: request.toJson(),
      );

      var converted = WrappedResponse<ProductResponse>.fromJson(
        response.data,
        (data) => ProductResponse.fromJson(data),
      );

      return ProductEntity.toEntity(converted.data!);
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }
}
