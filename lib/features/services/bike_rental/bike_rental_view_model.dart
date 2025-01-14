import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/models/bike_rental.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../breakfast_basket/breakfast_basket_view_model.dart';

class BikeRentalViewModel extends BaseViewModel {
  BikeRentalViewModel(this._servicesRepository);
  final ServicesRepository _servicesRepository;
  BikeRental? service;

  //datos del pedido
  List<RequestedService> items = [RequestedService()];
  String? _startDate;
  String? _endDate;

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

  void onInit() {
    getDetail();
  }

  Future<void> getDetail() async {
    busy = true;
    try {
      service = await _servicesRepository.getBikeRental();
      items.last.name = service?.products?.first.name;
      items.last.price = service?.products?.first.price;
      items.last.productId = service?.products?.first.id.toString();
    } catch (e) {
      Logger().e("ERROR $e");
    }
    busy = false;
  }

  set startDate(String? v) {
    _startDate = v;
    notifyListeners();
  }

  String? get startDate => _startDate;
  set endDate(String? v) {
    _endDate = v;
    notifyListeners();
  }

  String? get endDate => _endDate;

  void quantity(int i) {
    items.last.amount = i;
  }

  Future<bool> sendRequest() async {
    busy = true;
    try {
      await _servicesRepository.requestBikeRental(
        startDate: _startDate!,
        endDate: _endDate!,
        items: items,
      );
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
