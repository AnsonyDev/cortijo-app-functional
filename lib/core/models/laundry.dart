import 'package:cortijo_app/core/models/product_laundry.dart';

import 'category.dart';
import 'services.dart';

class Laundry {
  Service? service;
  List<Category>? categories;
  List<ProductLaundry>? products;

  Laundry({
    this.service,
    this.categories,
    this.products,
  });

  factory Laundry.fromJson(dynamic json) => Laundry(
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        products: json["products"] == null
            ? []
            : List<ProductLaundry>.from(
                json["products"]!.map((x) => ProductLaundry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
