import 'package:labamu/features/product/data/models/product_request.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity> getProductDetail(String id);
  Future<ProductEntity> createProduct(ProductRequest request);
  Future<ProductEntity> updateProduct(ProductRequest request);
}
