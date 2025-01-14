import 'product.dart';
import 'services.dart';
import 'timezone.dart';

class BreakfastBasket {
  Service? service;
  List<Timezone>? timezones;
  List<Product>? products;

  BreakfastBasket({
    this.service,
    this.timezones,
    this.products,
  });

  factory BreakfastBasket.fromJson(Map<String, dynamic> json) =>
      BreakfastBasket(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        timezones: json["timezones"] == null
            ? []
            : List<Timezone>.from(
                json["timezones"]!.map((x) => Timezone.fromJson(x))),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "timezones": timezones == null
            ? []
            : List<dynamic>.from(timezones!.map((x) => x.toJson())),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
