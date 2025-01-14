class Wifi {
  int? id;
  String? ssid;
  String? password;
  String? status;

  Wifi({
    this.id,
    this.ssid,
    this.password,
    this.status,
  });

  factory Wifi.fromJson(dynamic json) => Wifi(
        id: json["id"] as int?,
        ssid: json["ssid"] as String?,
        password: json["password"] as String?,
        status: json["status"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ssid": ssid,
        "password": password,
        "status": status,
      };
}
