library home_view;

import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/home/widgets/booking_widget.dart';
import 'package:cortijo_app/features/home/widgets/bookings_confirm_widget.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stacked/stacked.dart';
import '../../../core/data/requests_repository.dart';
import '../../../core/data/withdrawals_repository.dart';
import '../../routes/router.gr.dart';
import '../widgets/checkin_checkout.dart';
import '../widgets/know_us.dart';
import '../widgets/how_to_get.dart';
import '../widgets/playlist_cortijo.dart';
import '../widgets/services_cortijos.dart';
import '../widgets/tourist_information.dart';
import '../widgets/withdrawals.dart';
import 'home_view_model.dart';

part '../../../features/home/views/home_mobile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final model = HomeViewModel(
      locator<WithdrawalsRepository>(),
      locator<RequestsRepository>(),
      locator<ServicesRepository>(),
    );
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => model,
      onModelReady: (model) => model.onInit(),
      builder: (context, viewModel, child) {
        return _HomeMobile(viewModel);
      },
    );
  }
}
