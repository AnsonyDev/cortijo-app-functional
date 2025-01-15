library perfil_view;

import 'package:cortijo_app/core/data/tuya_repository.dart';
import 'package:cortijo_app/core/data/user_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_title.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import '../routes/router.gr.dart';
import '../wallet/wallet_view.dart' as w;
import 'perfil_view_model.dart';
import 'widgets/card_perfil.dart';

part '../perfil/perfil_mobile.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = PerfilViewModel(
      locator.get<UserRepository>(),
      locator.get<TuyaRepository>(),
    );
    return ViewModelBuilder<PerfilViewModel>.reactive(
      viewModelBuilder: () => model,
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return _PerfilMobile(model);
      },
    );
  }
}
