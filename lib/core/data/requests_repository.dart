import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
// import 'package:cortijo_app/core/services/shared_preferences.dart';

import '_api_classes.dart';
import '_base_api_url.dart';

class RequestsRepository {
  RequestsRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<String> bookingsWithdrawal({
    required String checkIn,
    required String checkOut,
    required String withdrawalId,
    required int guests,
  }) async {
    final dynamic res = await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/withdrawal',
      body: {
        "check_in": checkIn,
        "check_out": checkOut,
        "withdrawal_id": withdrawalId,
        "guests": guests.toString(),
      },
    );
    return res["booking"]["payment_url"];
  }

  Future<CheckBookinResponse> checkBookings() async {
    final dynamic res =
        await apiClient.getRequest('$BASE_API_URL/api/bookings/user');
    if ((res["haveBookings"] as bool)) {
      LocalDataRepository().booking = Booking.fromJson(res["booking"]);
    } else {
      LocalDataRepository().deleteBooking();
    }

    return CheckBookinResponse(
        hasRegisterGuestComplete: res["hasRegisterGuestComplete"] as bool,
        haveBookings: res["haveBookings"] as bool,
        booking: Booking.fromJson(res["booking"]),
        bookingsConfirm: res["bookingsConfirm"] == null
            ? []
            : List<Booking>.from(
                res["bookingsConfirm"]!.map((x) => Booking.fromJson(x))));
  }
}

class CheckBookinResponse {
  final bool hasRegisterGuestComplete;
  final bool haveBookings;
  final Booking booking;
  List<Booking>? bookingsConfirm;

  CheckBookinResponse({
    required this.haveBookings,
    required this.booking,
    required this.hasRegisterGuestComplete,
    this.bookingsConfirm,
  });
}
