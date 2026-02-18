class ProductRequest {
  final String? id;
  final String name;
  final int price;
  final String description;

  ProductRequest({
    this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
