import 'dart:convert';

class Product {
   Product({
      this.id,
      required this.available,
      this.image,
      required this.name,
      required this.price,
   });

   String? id;
   bool available;
   String? image;
   String name;
   int price;

   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

   String toJson() => json.encode(toMap());

   factory Product.fromMap(Map<String, dynamic> json) => Product(
      available: json["available"],
      image: json["image"],
      name: json["name"],
      price: json["price"],
   );

   Map<String, dynamic> toMap() => {
      "available": available,
      "image": image,
      "name": name,
      "price": price,
   };
}
