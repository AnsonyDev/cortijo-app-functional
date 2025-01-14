import 'dart:io';

import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/models/guests.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/data/checkin_repository.dart';
import '../../core/locator.dart';
import '../routes/router.gr.dart';

class CheckInViewModel extends BaseViewModel {
  CheckInViewModel(
    this._checkInRepository,
    this.booking,
  );

  final Booking booking;
  final ImagePicker picker = ImagePicker();
  final router = locator<AppRouter>();
  final genders = [
    Gender('man', "Masculino"),
    Gender('women', "Femenino"),
  ];

  Gender? genderSelected;

  List<Guests> guests = [];

  final CheckInRepository _checkInRepository;

  void onInit() {
    guests = [
      Guests.fromJson(booking.user!.toJson()),
      ...List.generate(booking.guests! - 1, (i) {
        return Guests();
      })
    ];
  }

  void changeFirstName(int i, String value) {
    guests[i].firstName = value;
    notifyListeners();
  }

  void changeLastName(int i, String value) {
    guests[i].lastName = value;
    notifyListeners();
  }

  void changeEmail(int i, String value) {
    guests[i].email = value;
    notifyListeners();
  }

  void changeBirthDay(int i, String value) {
    guests[i].birthDateString = value;
    notifyListeners();
  }

  void changeGenre(int i, Gender gender) {
    genderSelected = gender;
    guests[i].gender = gender.value;
    notifyListeners();
  }

  void changeNationality(int i, String value) {
    guests[i].nationality = value;
    notifyListeners();
  }

  void changeDocumentType(int i, String value) {
    guests[i].documentType = value;
    notifyListeners();
  }

  void changeDocumentNumber(int i, String value) {
    guests[i].documentNumber = value;
    notifyListeners();
  }

  void changeAddress(int i, String value) {
    guests[i].address = value;
    notifyListeners();
  }

  void changeProvince(int i, String value) {
    guests[i].province = value;
    notifyListeners();
  }

  void changeCity(int i, String value) {
    guests[i].city = value;
    notifyListeners();
  }

  void changeDNI(int i, String value) {
    guests[i].dni = value;
    notifyListeners();
  }

  void changePhone(int i, String value) {
    guests[i].phone = value;
    notifyListeners();
  }

  Future<void> loadFromtDocumet(int i) async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      guests[i].frontDocument = File(img.path);
      notifyListeners();
    }
  }

  Future<void> loadBackDocumet(int i) async {
    final XFile? img = await picker.pickImage(source: ImageSource.camera);
    if (img != null) {
      log!.i(img.path);
      guests[i].backDocument = File(img.path);
      notifyListeners();
    }
  }

  void loadSignature(int i, File signature) {
    guests[i].signature = signature;
    notifyListeners();
  }

  void deleteSignature(int i) {
    guests[i].signature = null;
    notifyListeners();
  }

  Future<void> checkIn(BuildContext context) async {
    busy = true;
    var res = await _checkInRepository.checkIn(
        guests: guests, bookingId: booking.id!);
    if (res) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(true);
    }

    busy = false;
  }
}

class Gender {
  final String value;
  final String label;

  Gender(this.value, this.label);
}
