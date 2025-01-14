library intro_view;

import 'package:auto_route/annotations.dart';
import 'package:cortijo_app/core/data/auth_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/intro_final_view.dart';
import 'package:cortijo_app/features/intro_authentication/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'intro_authentication_view_model.dart';
import 'widgets/bottom_sheet.dart';
import 'widgets/intro_views.dart';
import 'widgets/auth_widget.dart';

part 'intro_authentication_mobile.dart';

class IntroAuthenticationView extends StatelessWidget {
  const IntroAuthenticationView({
    @PathParam() this.logIn = false,
    super.key,
  });

  final bool logIn;

  @override
  Widget build(BuildContext context) {
    final model = IntroAuthanticationViewModel(locator<AuthRepository>());
    return ViewModelBuilder<IntroAuthanticationViewModel>.reactive(
      viewModelBuilder: () => model,
      onModelReady: (model) async {
        if (logIn) {
          await Future.delayed(Duration.zero, () {
            model.skip();
          });
        }
      },
      builder: (_, model, __) {
        return _IntroAuthenticationMobile(
          model,
          logIn: logIn,
        );
      },
    );
  }
}
