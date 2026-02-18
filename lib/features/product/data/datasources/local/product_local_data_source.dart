import 'dart:convert';
import 'package:labamu/core/local_storage/database/database_helper.dart';
import 'package:labamu/features/product/domain/entity/product_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductEntity>> getProducts();
  Future<ProductEntity?> getProductById(String id);
  Future<void> cacheProducts(List<ProductEntity> products);
  Future<void> cacheSingleProduct(ProductEntity product);
  Future<void> addQueueItem(String action, Map<String, dynamic> payload);
  Future<List<Map<String, dynamic>>> getQueueItems();
  Future<void> removeQueueItem(int id);
}
