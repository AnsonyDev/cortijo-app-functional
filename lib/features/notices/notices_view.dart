library notices_view;

import 'package:cortijo_app/core/data/notices_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/app_header.dart';
import '../home/widgets/tittle_home.dart';
import 'notices_view_model.dart';
import 'widgets/card_notice.dart';
import 'widgets/no_notice.dart';

part '../notices/notices_mobile.dart';

class NoticesView extends StatelessWidget {
  const NoticesView({super.key});

  @override
  Widget build(BuildContext context) {
    NoticesViewModel viewModel = NoticesViewModel(locator<NoticesRepository>());
    return ViewModelBuilder<NoticesViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _NoticesMobile(viewModel);
      },
    );
  }
}
