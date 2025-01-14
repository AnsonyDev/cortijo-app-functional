import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../../widgets/app_bottons.dart';

class IntroPag extends StatelessWidget {
  const IntroPag({
    required this.imgBack,
    required this.tittle,
    required this.content,
    required this.back,
    required this.next,
    required this.skip,
    required this.currentPage,
    Key? key,
  }) : super(key: key);

  final String imgBack;
  final String tittle;
  final String content;
  final void Function()? back;
  final void Function() next;
  final void Function()? skip;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(imgBack, fit: BoxFit.cover),
        Positioned.fill(child: Container(color: Colors.black45)),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    AppCircularButton(
                      colorButton: AppColors.whiteTransparent,
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.white,
                      ),
                      onPressed: back,
                    ),
                    const Spacer(),
                    Visibility(
                      visible: currentPage != 3,
                      child: AppOvalButton(
                          onPressed: skip,
                          text: 'Omitir',
                          colorButton: AppColors.whiteTransparent),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: currentPage == 1
                        ? AppColors.white
                        : AppColors.whiteTransparent,
                  ),
                  margin: const EdgeInsets.all(6),
                  height: 12,
                  width: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: currentPage == 2
                        ? AppColors.white
                        : AppColors.whiteTransparent,
                  ),
                  margin: const EdgeInsets.all(6),
                  height: 12,
                  width: 12,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: currentPage == 3
                        ? AppColors.white
                        : AppColors.whiteTransparent,
                  ),
                  margin: const EdgeInsets.all(6),
                  height: 12,
                  width: 12,
                ),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      tittle,
                      style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quiza pro'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      content,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    AppButton(
                      onPressed: next,
                      text: currentPage != 3 ? 'Siguiente' : 'Empecemos',
                      icon: currentPage != 3
                          ? const Icon(Icons.arrow_forward,
                              color: AppColors.oliveGreen)
                          : null,
                      color: currentPage != 3
                          ? AppColors.white
                          : AppColors.oliveGreen,
                      colorText: currentPage != 3
                          ? AppColors.oliveGreen
                          : AppColors.white,
                      border: true,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
