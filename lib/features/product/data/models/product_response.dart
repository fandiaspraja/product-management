import 'package:labamu/core/utils/serializable.dart';

class ProductResponse implements Serializable {
  String? id;
  String? name;
  int? price;
  String? description;
  String? status;
  String? updatedAt;

  ProductResponse({
    this.id,
    this.name,
    this.price,
    this.description,
    this.status,
    this.updatedAt,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      status: json['status'],
      updatedAt: json['updatedAt'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
