class Service {
  int? id;
  String? name;
  String? photo;
  String? description;
  String? dataSheet;

  Service({
    this.id,
    this.name,
    this.photo,
    this.description,
    this.dataSheet,
  });

  factory Service.fromJson(dynamic json) => Service(
        id: json["id"] as int?,
        name: json["name"] as String?,
        photo: json["photo"] as String?,
        description: json["description"] as String?,
        dataSheet: json["data_sheet"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "data_sheet": dataSheet,
      };
}
