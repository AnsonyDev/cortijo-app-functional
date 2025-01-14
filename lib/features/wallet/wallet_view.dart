library wallet_view;

import 'package:cortijo_app/core/data/auth_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/features/home/widgets/webview.dart';
import 'package:cortijo_app/features/wallet/widgets/transaccion.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../core/data/wallet_repository.dart';
import '../../widgets/app_bottons.dart';
import '../../widgets/app_header.dart';
import '../home/widgets/tittle_home.dart';
import 'wallet_view_model.dart';
import 'widgets/card_qr.dart';

part '../wallet/wallet_mobile.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key, this.isTransactions = false});
  final bool isTransactions;

  @override
  Widget build(BuildContext context) {
    final viewModel =
        WalletViewModel(locator<AuthRepository>(), locator<WalletRepository>());
    return ViewModelBuilder<WalletViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        viewModel.setIsTransactions(isTransactions);
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _WalletMobile(viewModel);
      },
    );
  }
}
