library welcome_view;

import 'package:cortijo_app/features/welcome/widgets/welcome_background.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/app_bottons.dart';
import 'welcome_view_model.dart';

part '../welcome/welcome_mobile.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = WelcomeViewModel();
    return ViewModelBuilder<WelcomeViewModel>.reactive(
      viewModelBuilder: () => model,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _WelcomeMobile(viewModel);
      },
    );
  }
}
