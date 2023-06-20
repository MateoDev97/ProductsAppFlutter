
import 'dart:convert';

class Product {

    String? id;
    bool available;
    String? image;
    String name;
    double price;

    Product({
        required this.available,
        this.image,
        required this.name,
        required this.price,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        available: json["available"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "image": image,
        "name": name,
        "price": price,
    };
}
