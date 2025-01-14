import 'package:auto_route/auto_route.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_botton_navigation.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/locator.dart';

late TabsRouter tabsRouterGlobal;

class RouterPage extends StatefulWidget {
  const RouterPage({Key? key, this.showWelcomeMessage = false})
      : super(key: key);

  final bool showWelcomeMessage;

  @override
  State<RouterPage> createState() => _RouterPageState();
}

class _RouterPageState extends State<RouterPage> {
  final router = locator<AppRouter>();

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          router.navigate(const AvisosRouter());
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      if (widget.showWelcomeMessage) {
        showDialog(
          context: context,
          builder: (_) {
            return const _WelcomeMessage();
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      floatingActionButton: LocalDataRepository().isLogged
          ? null
          : FloatingActionButton.extended(
              onPressed: () async {
                final url = Uri.parse('tel:+34 685 52 15 92');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              label: Text(
                "¿Necesitas ayuda?",
                textAlign: TextAlign.center,
                style: AppTextStyle.cardTitleStyle
                    .copyWith(color: Colors.white, fontSize: 12),
              )),
      backgroundColor: AppColors.fillerColor,
      routes: const [
        HomeRouter(),
        ServiciosRouter(),
        AvisosRouter(),
        WalletRouter(),
      ],
      homeIndex: 0,
      lazyLoad: false,
      bottomNavigationBuilder: (_, tabsRouter) {
        tabsRouterGlobal = tabsRouter;
        return LocalDataRepository().isLogged
            ? AppBottonNavigator(
                currentIndex: tabsRouter.activeIndex,
                onTap: (i) async {
                  await router.popTop();
                  tabsRouterGlobal.setActiveIndex(i);
                },
              )
            : const AppButtonInitSesion();
      },
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/imgs/BackGroundHome.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            spacerXL,
            Center(
              child: Text(
                "Bienvenidos a los Retiros Los Agustinos",
                textAlign: TextAlign.center,
                style: AppTextStyle.h1Style.copyWith(color: Colors.white),
              ),
            ),
            const Spacer(),
            AppButton(
              color: AppColors.oliveGreen,
              colorText: Colors.white,
              onPressed: () => Navigator.maybePop(context),
              text: 'Continuar',
              minWidth: 100,
            ),
            spacerXL
          ],
        ),
      ),
    );
  }
}
