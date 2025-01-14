import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/locator.dart';

import '../routes/router.gr.dart';

class WelcomeViewModel extends BaseViewModel {
  final _router = locator<AppRouter>();

  String backgroundImg = 'assets/imgs/welcome_background.png';
  String logoWhite = 'assets/icons/LOGO_BLANCO.svg';

  void goToIntro() => _router.push(IntroAuthenticationRouter());

  void goToLogin() => _router.push(IntroAuthenticationRouter(logIn: true));
}
