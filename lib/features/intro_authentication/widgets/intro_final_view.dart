import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';
import 'bottom_sheet.dart';

class IntroFinal extends StatelessWidget {
  const IntroFinal({
    required this.back,
    required this.createAccount,
    required this.accessWithoutCredentials,
    required this.accessHere,
    Key? key,
  }) : super(key: key);

  final void Function()? back;
  final Widget createAccount;
  final void Function()? accessWithoutCredentials;
  final Widget accessHere;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/imgs/intro-4.png',
            fit: BoxFit.cover, width: double.infinity),
        Positioned.fill(child: Container(color: Colors.black45)),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.white),
                    child: const AutoLeadingButton(
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 130),
                SvgPicture.asset('assets/icons/LOGO_BLANCO.svg', width: 150, color: Colors.white,),
                // const Spacer(),
              ],
            ),
          ),
        ),
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              AppButton(
                onPressed: () => modalBottomSheet(context, createAccount),
                text: 'Crear cuenta',
                colorText: AppColors.white,
                color: AppColors.oliveGreen,
              ),
              const SizedBox(height: 20),
              AppButton(
                onPressed: accessWithoutCredentials!,
                text: 'Acceder sin credenciales',
                colorText: AppColors.oliveGreen,
                color: AppColors.white,
                icon: const Icon(Icons.arrow_forward,
                    color: AppColors.oliveGreen, size: 20),
              ),
              const SizedBox(height: 20),
              const Center(
                  child: Text(
                '¿Ya tienes una reserva o cuenta?',
                style: TextStyle(color: AppColors.white, fontSize: 16),
              )),
              const SizedBox(height: 12),
              AppButton(
                onPressed: () => modalBottomSheet(context, accessHere),
                text: 'Accede aquí',
                colorText: AppColors.white,
                icon: const Icon(Icons.arrow_forward,
                    color: AppColors.white, size: 20),
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ],
    );
  }
}
