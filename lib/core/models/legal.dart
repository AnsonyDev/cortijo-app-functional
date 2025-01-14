class Legal {
  int? id;
  String? title;
  String? description;

  Legal({
    this.id,
    this.title,
    this.description,
  });

  factory Legal.fromJson(dynamic json) => Legal(
        id: json["id"] as int,
        title: json["title"] as String?,
        description: json["description"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
