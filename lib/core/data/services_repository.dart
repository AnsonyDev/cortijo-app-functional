import 'dart:convert';

import 'package:cortijo_app/core/models/bike_rental.dart';
import 'package:cortijo_app/core/models/breakfast_basket.dart';
import 'package:cortijo_app/core/models/laundry.dart';
import 'package:cortijo_app/core/models/services.dart';
import 'package:cortijo_app/core/models/shopping_car.dart';
import 'package:cortijo_app/core/models/user_data.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/services/breakfast_basket/breakfast_basket_view_model.dart';
import 'package:logger/logger.dart';

import '_api.dart';
import '_api_classes.dart';
import '_base_api_url.dart';

class ServicesRepository {
  ServicesRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<List<Service>> getServices() async {
    final dynamic res = await apiClient.getRequest(
      '$BASE_API_URL/api/all-services',
    );
    return (res["services"] as List).map(Service.fromJson).toList();
  }

  Future<BreakfastBasket> getBreakfastBasket() async {
    final dynamic res = await apiClient
        .getRequest('$BASE_API_URL/api/service', params: {"id": "1"});
    return BreakfastBasket.fromJson(res);
  }

  Future<void> requestBreakfast({
    required String date,
    String? observations,
    required int timezoneId,
    required List<RequestedService> items,
  }) async {
    final body = {
      "date": date,
      "observation": observations,
      "timezone_id": timezoneId.toString(),
      "items": items.map((e) => e.toRequest()).toList(),
    };

    Logger().i(jsonEncode(body));

    await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/breakfast',
      body: jsonEncode(body),
      customHeaders: headerContentTypeApplicationJson,
    );
  }

  Future<ShoppingCar> getShoppingCar() async {
    final dynamic res = await apiClient
        .getRequest('$BASE_API_URL/api/service', params: {"id": "2"});
    return ShoppingCar.fromJson(res);
  }

  Future<void> requestShoppingCar({
    required String date,
    required String? observations,
    required List<RequestedService> items,
  }) async {
    final body = {
      "date": date,
      "observation": observations,
      "items": items.map((e) => e.toRequest()).toList(),
    };

    Logger().i(body);

    await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/basket',
      body: jsonEncode(body),
      customHeaders: headerContentTypeApplicationJson,
    );
  }

  Future<BikeRental> getBikeRental() async {
    final dynamic res = await apiClient
        .getRequest('$BASE_API_URL/api/service', params: {"id": "3"});
    return BikeRental.fromJson(res);
  }

  Future<void> requestBikeRental({
    required String startDate,
    required String endDate,
    required List<RequestedService> items,
  }) async {
    final body = {
      "start_date": startDate,
      "end_date": endDate,
      "items": items.map((e) => e.toRequest()).toList(),
    };

    Logger().i(body);

    await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/bike-reservation',
      body: jsonEncode(body),
      customHeaders: headerContentTypeApplicationJson,
    );
  }

  Future<Laundry> getLaundry() async {
    final dynamic res = await apiClient
        .getRequest('$BASE_API_URL/api/service', params: {"id": "4"});
    return Laundry.fromJson(res);
  }

  Future<void> requestLaundry({
    required String date,
    required String observations,
    required int express,
    required List<RequestedService> items,
  }) async {
    final body = {
      "date": date,
      "express": express,
      "observation": observations,
      "items": items.map((e) => e.toRequest()).toList(),
    };

    Logger().i(body);

    await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/laundry',
      body: jsonEncode(body),
      customHeaders: headerContentTypeApplicationJson,
    );
  }

  Future<void> requestCleaning() async {
    // Logger().i(body);
    final body = {
      "batch": "morning",
    };

    await apiClient.postRequest(
      '$BASE_API_URL/api/bookings/cleaning',
      body: jsonEncode(body),
      customHeaders: headerContentTypeApplicationJson,
    );
    // Dialogs.sucess(msg: res["message"]);
  }

  Future<void> notDisturb(int value) async {
    final dynamic res = await apiClient.getRequest(
        '$BASE_API_URL/api/user/not_disturb',
        params: {"value": "$value"});
    final user = UserData.fromJson(res['user']);
    LocalDataRepository().user = user;
  }

  Future<String?> saveReview(
      {required int withdrawlId,
      required int rating,
      required String description}) async {
    final dynamic res =
        await apiClient.postRequest('$BASE_API_URL/api/reviews/save', body: {
      "withdrawal_id": withdrawlId.toString(),
      "rating": rating.toString(),
      "description": description,
    });
    return (res["message"] as String);
  }
}
