import 'package:cortijo_app/core/models/user_data.dart';

import 'withdrawals.dart';

class Booking {
  int? id;
  String? fullName;
  DateTime? checkIn;
  DateTime? checkOut;
  int? days;
  int? guests;
  int? total;
  String? status;
  int? userId;
  int? withdrawalId;
  UserData? user;
  String? avaibookId;
  String? avaibookInfo;
  String? paymentUrl;
  Withdrawal? withdrawal;

  Booking({
    this.id,
    this.fullName,
    this.checkIn,
    this.checkOut,
    this.days,
    this.guests,
    this.total,
    this.status,
    this.userId,
    this.withdrawalId,
    this.user,
    this.avaibookId,
    this.avaibookInfo,
    this.paymentUrl,
    this.withdrawal,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        fullName: json["full_name"],
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        days: json["days"],
        guests: json["guests"],
        total: json["total"],
        status: json["status"],
        userId: json["user_id"],
        withdrawalId: json["withdrawal_id"],
        user: json["customer"] == null
            ? null
            : UserData.fromJson(json["customer"]),
        avaibookId: json["avaibook_id"],
        avaibookInfo: json["avaibook_info"],
        paymentUrl: json["payment_url"],
        withdrawal: json["withdrawal"] == null
            ? null
            : Withdrawal.fromJson(json["withdrawal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "check_in":
            "${checkIn!.year.toString().padLeft(4, '0')}-${checkIn!.month.toString().padLeft(2, '0')}-${checkIn!.day.toString().padLeft(2, '0')}",
        "check_out":
            "${checkOut!.year.toString().padLeft(4, '0')}-${checkOut!.month.toString().padLeft(2, '0')}-${checkOut!.day.toString().padLeft(2, '0')}",
        "days": days,
        "guests": guests,
        "total": total,
        "status": status,
        "user_id": userId,
        "withdrawal_id": withdrawalId,
        "user": user?.toJson(),
        "avaibook_id": avaibookId,
        "avaibook_info": avaibookInfo,
        "payment_url": paymentUrl,
        "withdrawal": withdrawal?.toJson(),
      };
}
