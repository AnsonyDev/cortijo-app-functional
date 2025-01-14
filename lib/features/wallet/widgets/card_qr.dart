import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../wallet_view_model.dart';

class CardQR extends StatelessWidget {
  const CardQR(
    this.model, {
    Key? key,
  }) : super(key: key);

  final WalletViewModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/LOGO_NEUTRO.svg',
                      width: 60,
                      height: 60,
                    ),
                    const Text(
                        'Presenta el QR cuando adquieras algún servicio del Cortijo')
                  ],
                ),
              ),
            ),
            model.busy
                ? const MyShimmer(
                    height: 120,
                    width: 120,
                    borderRadius: 15,
                  )
                : Stack(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.oliveGreen),
                        child: Text(
                          model.pin ?? '',
                          style: AppTextStyle.h1Style
                              .copyWith(color: Colors.white, letterSpacing: 5),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                            onPressed: () {
                              model.newPin();
                            },
                            splashRadius: 0.5,
                            icon: const Icon(
                              Icons.replay_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
