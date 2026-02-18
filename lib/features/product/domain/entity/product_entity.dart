import 'package:equatable/equatable.dart';
import 'package:labamu/features/product/data/models/product_response.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? name;
  final int? price;
  final String? description;
  final String? status;
  final String? updatedAt;

  const ProductEntity({
    this.id,
    this.name,
    this.price,
    this.description,
    this.status,
    this.updatedAt,
  });

  factory ProductEntity.toEntity(ProductResponse response) {
    return ProductEntity(
      id: response.id,
      name: response.name,
      price: response.price,
      description: response.description,
      status: response.status,
      updatedAt: response.updatedAt,
    );
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'] as String?,
      name: map['name'] as String?,
      price: map['price'] as int?,
      description: map['description'] as String?,
      status: map['status'] as String?,
      updatedAt: map['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'status': status,
      'updatedAt': updatedAt,
    };
  }

  @override
  List<Object?> get props => [id, name, price, description, status, updatedAt];
}
