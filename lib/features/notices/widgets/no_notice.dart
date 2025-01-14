import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class NoResultWidget extends StatelessWidget {
  const NoResultWidget({Key? key, required this.visible, required this.text})
      : super(key: key);

  final bool visible;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
