class ProductRequest {
  final String? id;
  final String name;
  final int price;
  final String description;
  String? status;
  String? updatedAt;

  ProductRequest({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    this.status,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'description': description,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updatedAt': updatedAt,
    };
  }
}
