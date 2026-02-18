import 'package:dartz/dartz.dart';
import 'package:labamu/core/utils/failure.dart';
import 'package:labamu/features/product/data/models/product_request.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> createProduct(ProductRequest request);

  Future<Either<Failure, ProductEntity>> updateProduct(ProductRequest request);

  Future<Either<Failure, List<ProductEntity>>> getProducts();

  Future<Either<Failure, ProductEntity>> getProductDetail(String id);
}
