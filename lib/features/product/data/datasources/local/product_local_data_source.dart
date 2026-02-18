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

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper databaseHelper;

  ProductLocalDataSourceImpl({required this.databaseHelper});

  static const String _tblProducts = 'products';
  static const String _tblQueue = 'offline_queue';

  @override
  Future<void> cacheProducts(List<ProductEntity> products) async {
    final db = await databaseHelper.database;
    final batch = db.batch();

    batch.delete(_tblProducts);
    for (final product in products) {
      batch.insert(
        _tblProducts,
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<void> cacheSingleProduct(ProductEntity product) async {
    final db = await databaseHelper.database;
    await db.insert(
      _tblProducts,
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final db = await databaseHelper.database;
    final results = await db.query(
      _tblProducts,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.isNotEmpty ? ProductEntity.fromMap(results.first) : null;
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final db = await databaseHelper.database;
    final results = await db.query(_tblProducts);
    return results.map((data) => ProductEntity.fromMap(data)).toList();
  }

  @override
  Future<void> addQueueItem(String action, Map<String, dynamic> payload) async {
    final db = await databaseHelper.database;
    await db.insert(_tblQueue, {
      'action': action,
      'payload': jsonEncode(payload),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getQueueItems() async {
    final db = await databaseHelper.database;
    return await db.query(_tblQueue, orderBy: 'createdAt ASC');
  }

  @override
  Future<void> removeQueueItem(int id) async {
    final db = await databaseHelper.database;
    await db.delete(_tblQueue, where: 'id = ?', whereArgs: [id]);
  }
}
