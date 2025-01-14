import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/auth_repository.dart';
import 'package:cortijo_app/core/data/wallet_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/wallet_transactions.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';

class WalletViewModel extends BaseViewModel {
  final AuthRepository _authRepository;
  final WalletRepository _walletRepository;
  final router = locator<AppRouter>();

  WalletTransactions? _walletTransactions;
  List<BookingService> bookingService = [];
  bool isTransactions = false;

  String? pin;

  WalletViewModel(
    this._authRepository,
    this._walletRepository,
  ) {
    router.addListener(() {
      if (router.topRoute.name == "WalletView") {
        getPin(reloadPin: !isTransactions);
      }
    });

    // getPin();
  }

  void setIsTransactions(bool? v) {
    isTransactions = v ?? false;
    if (isTransactions) {
      getPin(reloadPin: !isTransactions);
    }
    notifyListeners();
  }

  WalletTransactions? get transactions => _walletTransactions;

  Future<void> getPin({bool reloadPin = true}) async {
    busy = true;
    try {
      // if (reloadPin) {
      //   pin = await _authRepository.getPin();
      // }
      _walletTransactions = await _walletRepository.getTransactions();
      bookingService = _walletTransactions?.bookingServices ?? [];
    } catch (e) {
      print(e.toString());
    }
    busy = false;
  }

  Future<void> newPin() async {
    busy = true;
    try {
      pin = await _authRepository.newPin();
    } catch (e) {
      Dialogs.error(msg: e.toString());
    }
    busy = false;
  }

  void filterTransaction(int id) {
    switch (id) {
      case 0:
        bookingService = _walletTransactions!.bookingServices!;
        notifyListeners();
        break;
      case 1:
        bookingService = _walletTransactions!.bookingServices!
            .where((e) => e.service!.id == 1 || e.service!.id == 2)
            .toList();
        notifyListeners();
        break;
      case 2:
        bookingService = _walletTransactions!.bookingServices!
            .where((e) => e.service!.id == 4)
            .toList();
        notifyListeners();
        break;
      case 3:
        bookingService = _walletTransactions!.bookingServices!
            .where((e) => e.service!.id == 3)
            .toList();
        notifyListeners();
        break;
      default:
        bookingService = _walletTransactions!.bookingServices!;
        notifyListeners();
    }
  }

  Future<void> pay() async {
    await _walletRepository.pagar();
  }
}

class TransaccionOptClass {
  String name;
  bool selected;
  int id;

  TransaccionOptClass(this.id, this.name, this.selected);
}
