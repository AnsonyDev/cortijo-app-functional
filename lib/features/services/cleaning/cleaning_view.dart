library cleaning_view;

import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/features/services/widgets/description_service_card.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_title.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'cleaning_view_model.dart';
// ignore: unused_import
import 'package:intl/intl.dart' as intl;

part '../cleaning/cleaning_mobile.dart';

class CleaningView extends StatelessWidget {
  const CleaningView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = CleaningViewModel(locator<ServicesRepository>());
    return ViewModelBuilder<CleaningViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        // viewModel.onInit();
      },
      builder: (context, viewModel, child) {
        return _CleaningMobile(viewModel);
      },
    );
  }
}
