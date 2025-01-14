import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CleaningViewModel extends BaseViewModel {
  CleaningViewModel(this._servicesRepository);
  final ServicesRepository _servicesRepository;
  // BikeRental? service;

  //datos del pedido
  // List<CleaningTimeZone> timezones = [
  //   CleaningTimeZone('Mañana', 'morning'),
  //   CleaningTimeZone('Tarde', 'afternoon'),
  //   CleaningTimeZone('Noche', 'night'),
  // ];
  // CleaningTimeZone? _timezone;

  // String? _date;

  final controller = PageController(initialPage: 0);
  double _currentPage = 0;

  double get currentPage => _currentPage;

  void previousPage() async {
    await controller.previousPage(
      duration: const Duration(milliseconds: 100),
      curve: Curves.ease,
    );
    _currentPage = controller.page!;

    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
    _currentPage = controller.page!;

    notifyListeners();
  }

  // set timezone(CleaningTimeZone? v) {
  //   _timezone = v;
  //   notifyListeners();
  // }

  // CleaningTimeZone? get timezone => _timezone;

  // set date(String? v) {
  //   _date = v;
  //   notifyListeners();
  // }

  // String? get date => _date;

  Future<bool> sendRequest() async {
    busy = true;
    try {
      await _servicesRepository.requestCleaning();
      busy = false;
      return true;
    } catch (e) {
      Logger().e(e);
      Dialogs.error(msg: e.toString());
      busy = false;
      return false;
    }
  }
}

class CleaningTimeZone {
  final String name;
  final String value;

  CleaningTimeZone(this.name, this.value);

  @override
  String toString() {
    return name;
  }
}
