import 'booking.dart';
import 'services.dart';
import 'timezone.dart';

class WalletTransactions {
  Booking? booking;
  List<BookingService>? bookingServices;

  WalletTransactions({
    this.booking,
    this.bookingServices,
  });

  factory WalletTransactions.fromJson(dynamic json) => WalletTransactions(
        booking:
            json["booking"] == null ? null : Booking.fromJson(json["booking"]),
        bookingServices: json["bookingServices"] == null
            ? []
            : List<BookingService>.from(json["bookingServices"]!
                .map((x) => BookingService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booking": booking?.toJson(),
        "bookingServices": bookingServices == null
            ? []
            : List<dynamic>.from(bookingServices!.map((x) => x.toJson())),
      };
}

class BookingService {
  int? id;
  int? bookingId;
  Service? service;
  DateTime? startDate;
  DateTime? endDate;
  int? days;
  int? express;
  String? status;
  Timezone? timezone;
  List<Item>? items;
  int? total;

  BookingService({
    this.id,
    this.bookingId,
    this.service,
    this.startDate,
    this.endDate,
    this.days,
    this.express,
    this.status,
    this.timezone,
    this.items,
    this.total,
  });

  factory BookingService.fromJson(Map<String, dynamic> json) => BookingService(
        id: json["id"],
        bookingId: json["booking_id"],
        service:
            json["service"] == null ? null : Service.fromJson(json["service"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        days: json["days"],
        express: json["express"],
        status: json["status"],
        timezone: json["timezone"] == null
            ? null
            : Timezone.fromJson(json["timezone"]),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "service": service?.toJson(),
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "days": days,
        "express": express,
        "status": status,
        "timezone": timezone?.toJson(),
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "total": total,
      };
}

class Item {
  int? id;
  String? productName;
  int? unitPrice;
  int? amount;
  int? total;
  DateTime? createdAt;

  Item({
    this.id,
    this.productName,
    this.unitPrice,
    this.amount,
    this.total,
    this.createdAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        productName: json["product_name"],
        unitPrice: json["unit_price"],
        amount: json["amount"],
        total: json["total"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "unit_price": unitPrice,
        "amount": amount,
        "total": total,
        "created_at": createdAt?.toIso8601String(),
      };
}
