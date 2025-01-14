class Category {
  int? id;
  String? name;
  int? serviceId;

  Category({
    this.id,
    this.name,
    this.serviceId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        serviceId: json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "service_id": serviceId,
      };
}
