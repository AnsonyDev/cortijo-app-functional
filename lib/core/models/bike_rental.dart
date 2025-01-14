import 'product.dart';
import 'services.dart';

class BikeRental {
  Service? service;
  List<Product>? products;

  BikeRental({
    this.service,
    this.products,
  });

  factory BikeRental.fromJson(Map<String, dynamic> json) => BikeRental(
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
