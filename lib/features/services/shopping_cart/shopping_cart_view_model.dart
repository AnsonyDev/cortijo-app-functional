import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/models/product.dart';
import 'package:cortijo_app/core/models/shopping_car.dart';
import 'package:cortijo_app/features/services/breakfast_basket/breakfast_basket_view_model.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

class ShoppingCartViewModel extends BaseViewModel {
  ShoppingCartViewModel(this._servicesRepository);
  final ServicesRepository _servicesRepository;
  ShoppingCar? service;

  //datos del pedido
  List<RequestedService> items = [RequestedService()];
  String? _date;
  String? _observations;
  RequestedService? itemSelected;

// Control page
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
      service = await _servicesRepository.getShoppingCar();
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

  set date(String? v) {
    _date = v;
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

  void observations(String? v) {
    _observations = v;
    notifyListeners();
  }

  Future<bool> sendRequest() async {
    busy = true;
    try {
      await _servicesRepository.requestShoppingCar(
        date: _date!,
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
