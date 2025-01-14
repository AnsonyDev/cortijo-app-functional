import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/models/category.dart';
import 'package:cortijo_app/core/models/laundry.dart';
import 'package:cortijo_app/core/models/product_laundry.dart';
import 'package:cortijo_app/features/services/breakfast_basket/breakfast_basket_view_model.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LaundryViewModel extends BaseViewModel {
  final ServicesRepository _servicesRepository;
  LaundryViewModel(this._servicesRepository);
  Laundry? service;

  //datos del pedido
  List<RequestedService> items = [RequestedService()];
  String? _date;
  RequestedService? itemSelected;
  bool _serviseExpress = false;
  Category? _category;
  String? _observations;

//Control page
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

  set express(bool? value) {
    _serviseExpress = value!;
    notifyListeners();
  }

  bool? get express => _serviseExpress;

  ProductLaundry? _productTemp;

  Category? get category => _category;

  set category(Category? v) {
    _category = v;
    notifyListeners();
  }

  void onInit() {
    getDetail();
  }

  Future<void> getDetail() async {
    busy = true;
    try {
      service = await _servicesRepository.getLaundry();
    } catch (e) {
      Logger().e("ERROR $e");
    }
    busy = false;
  }

  ProductLaundry? get product => _productTemp;

  set product(ProductLaundry? v) {
    _productTemp = v;
    items.last.name = v!.name;
    items.last.price = v.price;
    notifyListeners();
  }

  set date(String? v) {
    _date = v;
    notifyListeners();
  }

  void observations(String? v) {
    _observations = v;
    notifyListeners();
  }

  String? get date => _date;

  void quantity(int i) {
    itemSelected!.amount = i;
  }

  void addShoppingCar() {
    items.add(RequestedService());
    notifyListeners();
  }

  void selectItem(RequestedService item) {
    itemSelected = item;
    itemSelected!.productId = _productTemp!.id.toString();
  }

  Future<bool> sendRequest() async {
    busy = true;
    try {
      await _servicesRepository.requestLaundry(
        date: _date!,
        express: _serviseExpress ? 1 : 0,
        observations: _observations ?? '',
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

class LaundryCategory {
  String name;
  String desc;
  String price;

  LaundryCategory({
    required this.name,
    required this.desc,
    required this.price,
  });
}
