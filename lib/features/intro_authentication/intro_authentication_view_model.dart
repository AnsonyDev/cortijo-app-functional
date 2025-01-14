import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/auth_repository.dart';
import 'package:cortijo_app/main.dart';
import 'package:flutter/material.dart';

import '../../core/locator.dart';
import '../routes/router.gr.dart';

class IntroAuthanticationViewModel extends BaseViewModel {
  IntroAuthanticationViewModel(this._authRepository);
  final navigator = locator<AppRouter>();
  final AuthRepository _authRepository;

  final pageController = PageController(initialPage: 0);

  // login
  bool _showPasswordLogin = true;
  bool _showSetPassword = true;
  bool _showSetPasswordConfirm = true;
  bool _showPasswordSignUp = true;
  bool _showPasswordSignUpComfirm = true;
  bool _keepSavedData = false;
  bool _acceptTermins = false;
  bool _acceptTermins2 = false;

  // Loading

  String? _name;
  String? _lastName;
  String? _email;
  String? _password;
  String? _passwordConfirm;

  void name(String? value) {
    _name = value;
    notifyListeners();
  }

  void lastName(String? value) {
    _lastName = value;
    notifyListeners();
  }

  void email(String? value) {
    _email = value;
    notifyListeners();
  }

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  String? get password => _password;

  set passwordConfirm(String? value) {
    _passwordConfirm = value;
    notifyListeners();
  }

  String? get passwordConfirm => _passwordConfirm;

  void goBack() => navigator.pop();

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }

  Future<void> previousPage() async {
    await pageController.previousPage(
        duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
  }

  Future<void> skip() async {
    await pageController.animateToPage(4,
        duration: const Duration(microseconds: 1), curve: Curves.easeIn);
  }

  bool get showPassword => _showPasswordLogin;
  set showPassword(bool value) {
    _showPasswordLogin = value;
    notifyListeners();
  }

  bool get showSetPassword => _showSetPassword;
  set showSetPassword(bool value) {
    _showSetPassword = value;
    notifyListeners();
  }

  bool get showSetPasswordConfirm => _showSetPasswordConfirm;
  set showSetPasswordConfirm(bool value) {
    _showSetPasswordConfirm = value;
    notifyListeners();
  }

  bool get showPasswordSignUp => _showPasswordSignUp;
  set showPasswordSignUp(bool value) {
    _showPasswordSignUp = value;
    notifyListeners();
  }

  bool get showPasswordSignUpComfirm => _showPasswordSignUpComfirm;
  set showPasswordSignUpComfirm(bool value) {
    _showPasswordSignUpComfirm = value;
    notifyListeners();
  }

  bool get keepSavedData => _keepSavedData;
  set keepSavedData(bool value) {
    _keepSavedData = value;
    notifyListeners();
  }

  bool get acceptTermins => _acceptTermins;
  set acceptTermins(bool value) {
    _acceptTermins = value;
    notifyListeners();
  }

  bool get acceptTermins2 => _acceptTermins2;
  set acceptTermins2(bool value) {
    _acceptTermins2 = value;

    notifyListeners();
  }

  Future<void> goToHome() async {
    await navigator.push(RouterRoute(showWelcomeMessage: true));
  }

  Future<bool> initSession() async {
    busy = true;
    try {
      await _authRepository.login(email: _email!, password: _password!);
      await navigator.pushAndPopUntil(
        RouterRoute(showWelcomeMessage: true),
        predicate: (route) => false,
      );
      busy = false;
      return true;
    } catch (e) {
      log!.e('ERROR LOGGIN ${e.toString()}');
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
      busy = false;
      return false;
    }
  }

  Future<void> register() async {
    busy = true;
    try {
      await _authRepository.register(
        firstname: _name!,
        lastname: _lastName!,
        email: _email!,
        password: _password!,
        passwordConfirmation: _passwordConfirm!,
      );
      await navigator.pushAndPopUntil(
        RouterRoute(showWelcomeMessage: true),
        predicate: (route) => false,
      );
    } catch (e) {
      log!.e('ERROR Register ${e.toString()}');
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    busy = false;
  }

  Future<void> forgotPassword() async {
    busy = true;
    try {
      String? data = await _authRepository.forgotPassword(email: _email!);
      navigator.pop();
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(data ?? '')));
    } catch (e) {
      log!.e('ERROR Register ${e.toString()}');
      scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    busy = false;
  }
}
