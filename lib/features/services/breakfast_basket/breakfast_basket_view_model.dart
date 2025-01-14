import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/models/breakfast_basket.dart';
import 'package:cortijo_app/core/models/product.dart';
import 'package:cortijo_app/core/models/timezone.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class BreakfastBasketViewModel extends BaseViewModel {
  BreakfastBasketViewModel(this._servicesRepository);
  final ServicesRepository _servicesRepository;
  BreakfastBasket? service;

  // datos del pedido
  List<RequestedService> items = [RequestedService()];
  String? _date;
  String? _observations;
  Timezone? _timezone;
  RequestedService? itemSelected;

  final controller = PageController(initialPage: 0);

  double _currentPage = 0;

  Product? _productTemp;

  void onInit() {
    getDetail();
  }

  void selectItem(RequestedService item) {
    itemSelected = item;
    itemSelected!.productId = _productTemp!.id.toString();
  }

  Future<void> getDetail() async {
    busy = true;
    try {
      service = await _servicesRepository.getBreakfastBasket();
    } catch (e) {
      Logger().e("ERROR $e");
    }
    busy = false;
  }

  Product? get product => _productTemp;

  set product(Product? v) {
    _productTemp = v;
    items.last.name = v!.name;
    items.last.price = v.price;
    notifyListeners();
  }

  set timezone(Timezone? v) {
    _timezone = v;
    notifyListeners();
  }

  Timezone? get timezone => _timezone;

  set date(String? v) {
    _date = v;
    notifyListeners();
  }

  String? get date => _date;

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

  void quantity(int i) {
    itemSelected!.amount = i;
  }

  void observations(String? v) {
    _observations = v;
    notifyListeners();
  }

  void addBreakfast() {
    items.add(RequestedService());

    notifyListeners();
  }

  Future<bool> sendRequest() async {
    busy = true;
    try {
      await _servicesRepository.requestBreakfast(
        date: _date!,
        timezoneId: _timezone!.id,
        observations: _observations,
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

class RequestedService {
  String? name;
  int? price;
  String? productId;
  int amount;

  RequestedService({
    this.name,
    this.price,
    this.productId,
    this.amount = 1,
  });

  Map<String, dynamic> toRequest() => {
        "product_id": productId,
        "amount": amount,
      };
}

class ServiceDescription {
  String name;
  String desc;
  ServiceDescription(this.name, this.desc);
}
