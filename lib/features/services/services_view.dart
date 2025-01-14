library servicios_view;

import 'package:auto_route/auto_route.dart' as ra;
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/services.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';
import 'package:cortijo_app/features/services/widgets/card_services.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/app_header.dart';
import 'services_view_model.dart';

part '../services/services_mobile.dart';

class ServiciosView extends StatelessWidget {
  const ServiciosView({super.key});

  @override
  Widget build(BuildContext context) {
    ServiciosViewModel viewModel = ServiciosViewModel(
      locator<ServicesRepository>(),
    );
    return ViewModelBuilder<ServiciosViewModel>.reactive(
      viewModelBuilder: () => viewModel,
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return _ServiciosMobile(viewModel);
      },
    );
  }
}
