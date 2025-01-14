class Product {
  int? id;
  String? name;
  int? price;
  List<String>? dataSheet;
  String? description;
  String? observations;
  String? photo;
  int? categoryId;
  String? categoryName;

  Product(
      {this.id,
      this.name,
      this.price,
      this.dataSheet,
      this.description,
      this.observations,
      this.photo,
      this.categoryId,
      this.categoryName});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        dataSheet: json["data_sheet"] == null
            ? []
            : List<String>.from(json["data_sheet"]!.map((x) => x)),
        description: json["description"],
        observations: json["observations"],
        photo: json["photo"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "data_sheet": dataSheet == null
            ? []
            : List<dynamic>.from(dataSheet!.map((x) => x)),
        "description": description,
        "observations": observations,
        "photo": photo,
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
