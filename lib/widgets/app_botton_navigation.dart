import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors.dart';
import 'app_bottons.dart';

class AppBottonNavigator extends StatefulWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const AppBottonNavigator({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AppBottonNavigator> createState() => _AppBottonNavigatorState();
}

class _AppBottonNavigatorState extends State<AppBottonNavigator> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: BottomNavigationBar(
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.oliveGreen,
          unselectedItemColor: AppColors.black,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/icon-home.svg',
                color: widget.currentIndex == 0
                    ? AppColors.oliveGreen
                    : Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/icon-services.svg',
                color: widget.currentIndex == 1
                    ? AppColors.oliveGreen
                    : Colors.black,
              ),
              label: 'Servicios',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/icon-avisos.svg',
                color: widget.currentIndex == 2
                    ? AppColors.oliveGreen
                    : Colors.black,
              ),
              label: 'Avisos',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/icon-wallet.svg',
                color: widget.currentIndex == 3
                    ? AppColors.oliveGreen
                    : Colors.black,
              ),
              label: 'Wallet',
            ),
          ],
        ),
      ),
    );
  }
}

class AppButtonInitSesion extends StatelessWidget {
  const AppButtonInitSesion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: AppButton(
            onPressed: () => Navigator.of(context).pop(),
            text: 'Iniciar sesión',
            color: AppColors.white,
            border: true,
            colorText: AppColors.oliveGreen,
          ),
        ),
      ),
    );
  }
}
