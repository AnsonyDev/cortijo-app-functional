import 'dart:developer';
import 'dart:io';

import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../models/guests.dart';
import '../services/shared_preferences.dart';
import '_api_classes.dart';
import '_base_api_url.dart';

class CheckInRepository {
  CheckInRepository(this.apiClient);

  final MyApiClient apiClient;

  Future<bool> checkIn({
    required List<Guests> guests,
    required int bookingId,
  }) async {
    List<Map<String, dynamic>> guestsJson =
        guests.map((e) => e.toJson()).toList();

    FormData formData = FormData();

    formData.fields.add(MapEntry('booking_id', bookingId.toString()));

    for (int i = 0; i < guestsJson.length; i++) {
      var guest = guestsJson[i];
      guest.forEach((key, value) async {
        if (key != 'front_document' &&
            key != 'back_document' &&
            key != 'signature') {
          formData.fields.add(MapEntry('guests[$i][$key]', value.toString()));
        } else if (value != "") {
          log(value);
          formData.files.add(MapEntry(
            'guests[$i][$key]',
            await MultipartFile.fromFile(value),
          ));
        }
      });
    }

    final token = LocalDataRepository().authToken;
    try {
      final Response res = await Dio()
          .post('$BASE_API_URL/api/bookings/check-in',
              options: Options(headers: {
                'Authorization': 'Bearer $token',
                'Accept': 'application/json',
                'enctype': 'multipart/form-data'
              }),
              data: formData)
          .timeout(const Duration(seconds: 60));
      Dialogs.sucess(msg: res.data['message']);
      log(res.toString());
      return true;
    } catch (e) {
      if (e is DioException) {
        Dialogs.error(msg: e.response?.data['message'] ?? '');

        Logger().e(e.response.toString());
        return false;
      } else {
        Logger().e(e.toString());
        return false;
      }
    }
  }
}

/*
    List<Object> guestsFormData = <Object>[];

    for (var guest in guests) {
      final formData = {
        'firstname': guest.firstName,
        'lastname': guest.lastName,
        'email': guest.email ?? "",
        'birth_date': guest.birthDate ?? "",
        'gender': guest.gender,
        'nationality': guest.nationality ?? "",
        'document_type': guest.documentType ?? "",
        'document_number': guest.documentNumber ?? "",
        'address': guest.address ?? "",
        'province': guest.province ?? "",
        'city': guest.city ?? "",
        'dni': guest.dni ?? "",
        'phone': guest.phone ?? "",
      };
      if (guest.frontDocument != null) {
        formData.addAll({
          'front_document': await MultipartFile.fromFile(
              guest.frontDocument?.path ?? '',
              filename: 'frontDocument.jpg'),
        });
      }
      if (guest.backDocument != null) {
        formData.addAll({
          'back_document': await MultipartFile.fromFile(
              guest.backDocument?.path ?? '',
              filename: 'backDocument.jpg'),
        });
      }
      if (guest.signature != null) {
        formData.addAll({
          'signature': await MultipartFile.fromFile(guest.signature?.path ?? '',
              filename: 'signature.png'),
        });
      }

      guestsFormData.add(formData);
    }*/

    // var data = {
    //   'guests': guestsFormData,
    //   'booking_id': bookingId,
    // };

    // log(data.toString());
