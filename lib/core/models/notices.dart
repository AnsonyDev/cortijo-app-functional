class Notices {
  String? id;
  String? data;
  DateTime? createdAt;
  DateTime? updatedAt;

  Notices({
    this.id,
    this.data,
    this.createdAt,
    this.updatedAt,
  });

  factory Notices.fromJson(dynamic json) => Notices(
        id: json["id"] as String,
        data: json["data"]["message"] as String,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "data": data,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
