import 'package:dartz/dartz.dart';
import 'package:labamu/core/utils/failure.dart';
import 'package:labamu/features/product/data/models/product_request.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:labamu/features/product/domain/repository/product_repository.dart';

class StudentUsecase {
  final ProductRepository repository;

  StudentUsecase({required this.repository});

  Future<Either<Failure, ProductEntity>> createProduct(ProductRequest request) {
    return repository.createProduct(request);
  }

  Future<Either<Failure, ProductEntity>> updateProduct(ProductRequest request) {
    return repository.updateProduct(request);
  }

  Future<Either<Failure, List<ProductEntity>>> getProducts() {
    return repository.getProducts();
  }

  Future<Either<Failure, ProductEntity>> getProductDetail(String id) {
    return repository.getProductDetail(id);
  }
}
