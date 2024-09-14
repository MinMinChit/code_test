class ProductModel {
  int? id;
  final String name;
  final int price;
  final int discount;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      discount: json['discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'discount': discount,
    };
  }

  static List<ProductModel> productListFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
