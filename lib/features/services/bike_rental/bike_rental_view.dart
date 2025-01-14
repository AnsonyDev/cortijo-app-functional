library bike_rental_view;

import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/features/services/widgets/description_service_card.dart';
import 'package:cortijo_app/features/services/widgets/item_card_service.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_counter_widget.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_title.dart';
import 'package:cortijo_app/widgets/my_calendar.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'bike_rental_view_model.dart';
import 'package:intl/intl.dart' as intl;

part '../bike_rental/bike_rental_mobile.dart';

class BikeRentalView extends StatelessWidget {
  const BikeRentalView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = BikeRentalViewModel(locator<ServicesRepository>());
    return ViewModelBuilder<BikeRentalViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        viewModel.onInit();
      },
      builder: (context, viewModel, child) {
        return _BikeRentalMobile(viewModel);
      },
    );
  }
}
