import 'product.dart';
import 'services.dart';

class ShoppingCar {
  Service? service;
  List<Product>? products;

  ShoppingCar({
    this.service,
    this.products,
  });

  factory ShoppingCar.fromJson(Map<String, dynamic> json) => ShoppingCar(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
