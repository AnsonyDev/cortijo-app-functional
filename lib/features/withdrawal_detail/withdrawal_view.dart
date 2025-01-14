library withdrawal_view;

import 'package:cortijo_app/core/models/withdrawals.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/home/views/home_view_model.dart';
import 'package:cortijo_app/features/home/widgets/checkin_checkout.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/app_bottons.dart';
import '../../widgets/my_spacer/my_spacer.dart';
import 'widgets/withdrawal_card.dart';
import 'widgets/withdrawal_info.dart';
import 'withdrawal_view_model.dart';

part '../withdrawal_detail/withdrawal_mobile.dart';

class WithdrawalView extends StatelessWidget {
  const WithdrawalView({
    super.key,
    required this.withdrawal,
    required this.homeModel,
  });
  final Withdrawal withdrawal;
  final HomeViewModel homeModel;

  @override
  Widget build(BuildContext context) {
    final model = WithdrawalViewModel(withdrawal);
    return ViewModelBuilder<WithdrawalViewModel>.reactive(
      viewModelBuilder: () => model,
      onModelReady: (model) {
        // Do something once your model is initialized
      },
      builder: (context, model, child) {
        return _WithdrawalMobile(model, homeModel);
      },
    );
  }
}
