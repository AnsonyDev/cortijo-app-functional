import 'package:auto_route/auto_route.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/locator.dart';
import '../theme/colors.dart';
import 'app_bottons.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    this.isHome = false,
    this.isPeril = false,
    this.back,
    Key? key,
  }) : super(key: key);

  final bool isHome;
  final bool isPeril;
  final VoidCallback? back;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!isHome)
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: AppColors.white,
                    shape: const CircleBorder(),
                    child: back == null
                        ? const AutoLeadingButton(
                            color: AppColors.black,
                          )
                        : IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: back!,
                          ),
                  )),
            if (!isHome) const Spacer(),
            AppCircularButton(
                onPressed: () async {
                  final url = Uri.parse('tel:+34 685 521 592');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: SvgPicture.asset('assets/icons/icon-call.svg', width: 22),
                colorButton: AppColors.white),
            if (!isPeril)
              AppCircularButton(
                onPressed: () {
                  locator<AppRouter>().navigate(const PerfilView());
                },
                icon: SvgPicture.asset(
                  'assets/icons/icon-perfil.svg',
                  width: 20,
                ),
                colorButton: AppColors.white,
              ),
          ],
        ),
      ),
    );
  }
}
