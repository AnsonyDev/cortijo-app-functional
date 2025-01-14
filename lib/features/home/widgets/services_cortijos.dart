import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/services.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/home/views/home_view_model.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/features/route.dart';
import 'package:cortijo_app/widgets/my_network_image.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import '../../routes/router.gr.dart';

class ServicesCortijosWidget extends StatelessWidget {
  const ServicesCortijosWidget(this.model, {Key? key}) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TittleHome(tittle: 'Servicios Cortijo'),
          model.loadingServices
              ? const Expanded(
                  child: MyShimmer(
                    margin: EdgeInsets.all(15),
                    height: 220,
                  ),
                )
              : Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 0.9),
                    children: model.services
                        .map((e) => ServiceCard(
                              service: e,
                              onPressed: () {
                                switch (e.id) {
                                  case 1:
                                    tabsRouterGlobal.setActiveIndex(1);
                                    locator<AppRouter>().push(
                                      const BreakfastBasketRouter(),
                                    );
                                    break;
                                  case 2:
                                    tabsRouterGlobal.setActiveIndex(1);
                                    locator<AppRouter>().push(
                                      const ShoppingCartRouter(),
                                    );
                                    break;
                                  case 3:
                                    tabsRouterGlobal.setActiveIndex(1);
                                    locator<AppRouter>().push(
                                      const BikeRentalRouter(),
                                    );
                                    break;
                                  case 4:
                                    tabsRouterGlobal.setActiveIndex(1);
                                    locator<AppRouter>().push(
                                      const LaundryRouter(),
                                    );
                                    break;
                                }
                              },
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.onPressed,
    required this.service,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final Service service;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: MyNetworkImage(
                  image: service.photo!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    ' ${service.name ?? ''}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                AppOvalButton(
                    onPressed:
                        LocalDataRepository().isLogged ? onPressed : null,
                    text: ' Extra ',
                    colorButton: AppColors.grey)
              ],
            )
          ],
        ),
      ),
    );
  }
}
