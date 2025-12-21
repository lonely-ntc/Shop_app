import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavorite,
    required this.sluong,
  });

  String? image;
  String id;
  bool isFavorite;
  String name;
  double price;
  String description;

  int? sluong;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isFavorite: false,
        price: double.parse(json["price"].toString()),
        sluong: json['sluong'] != null
            ? int.tryParse(json['sluong'].toString()) ?? 1
            : 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'isFavorite': isFavorite,
        'price': price,
        'sluong': sluong,
      };

  ProductModel copyWith({
    int? sluong,
  }) =>
      ProductModel(
        id: id,
        name: name,
        description: description,
        image: image,
        isFavorite: isFavorite,
        price: price,
        sluong: sluong ?? this.sluong,
      );
}
