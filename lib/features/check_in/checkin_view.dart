library checkin_view;

import 'dart:io';

import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/core/utils/uint8list_to_file.dart';
import 'package:cortijo_app/core/utils/validators.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/app_textfield.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:cortijo_app/widgets/tap_to_hide_keyboard.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:stacked/stacked.dart';
import '../../core/data/checkin_repository.dart';
import 'checkin_view_model.dart';

part '../check_in/checkin_mobile.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({required this.booking, super.key});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    CheckInViewModel viewModel =
        CheckInViewModel(locator<CheckInRepository>(), booking);
    return ViewModelBuilder<CheckInViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {
        viewModel.onInit();
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _CheckInMobile(viewModel);
      },
    );
  }
}
