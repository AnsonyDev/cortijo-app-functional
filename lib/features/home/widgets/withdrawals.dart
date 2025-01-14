import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/withdrawals.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/home/views/home_view_model.dart';
import 'package:cortijo_app/features/routes/router.gr.dart' as route;
import 'package:cortijo_app/features/withdrawal_detail/withdrawal_view.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/my_network_image.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';

import 'tittle_home.dart';

class WithdrawalsWidget extends StatelessWidget {
  const WithdrawalsWidget(this.model, {Key? key}) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TittleHome(tittle: 'Descubre nuestros Retiros'),
          model.busy
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
                    children: model.withdrawals
                        .map((e) => WithdrawalsCard(
                              withdrawal: e,
                              onPressed: () {
                                locator<route.AppRouter>().navigate(
                                    route.WithdrawalView(
                                        withdrawal: e, homeModel: model));
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

class WithdrawalsCard extends StatelessWidget {
  const WithdrawalsCard({
    required this.onPressed,
    required this.withdrawal,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final Withdrawal withdrawal;
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
                child: (withdrawal.photos?.isNotEmpty ?? false)
                    ? MyNetworkImage(
                        image: withdrawal.photos!.first,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image_not_supported_outlined, size: 50),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    ' ${withdrawal.name ?? ''}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                AppOvalButton(
                  onPressed: LocalDataRepository().isLogged ? onPressed : null,
                  text: ' Ver más ',
                  colorButton: AppColors.grey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
