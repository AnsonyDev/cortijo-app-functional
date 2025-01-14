class Withdrawal {
  int? id;
  String? name;
  String? wifi;
  int? active;
  int? capacity;
  int? additionalCapacity;
  int? minimumStay;
  int? weekPrice;
  int? weekendPrice;
  int? forceWeekend;
  int? unitId;
  List<String>? photos;

  Withdrawal({
    this.id,
    this.name,
    this.wifi,
    this.active,
    this.capacity,
    this.additionalCapacity,
    this.minimumStay,
    this.weekPrice,
    this.weekendPrice,
    this.forceWeekend,
    this.unitId,
    this.photos,
  });

  factory Withdrawal.fromJson(dynamic json) => Withdrawal(
        id: json["id"] as int?,
        name: json["name"] as String?,
        wifi: json["wifi"] as String?,
        active: json["active"] as int?,
        capacity: json["capacity"] as int?,
        additionalCapacity: json["additionalCapacity"] as int?,
        minimumStay: json["minimumStay"] as int?,
        weekPrice: json["weekPrice"] as int?,
        weekendPrice: json["weekendPrice"] as int?,
        forceWeekend: json["forceWeekend"] as int?,
        unitId: json["unit_id"] as int?,
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "wifi": wifi,
        "active": active,
        "capacity": capacity,
        "additionalCapacity": additionalCapacity,
        "minimumStay": minimumStay,
        "weekPrice": weekPrice,
        "weekendPrice": weekendPrice,
        "forceWeekend": forceWeekend,
        "unit_id": unitId,
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
      };
}
