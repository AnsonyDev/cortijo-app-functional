import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.text,
    this.color,
    this.colorText,
    this.disabled = false,
    this.isLoading = false,
    this.icon,
    this.border = false,
    this.textSmall = false,
    this.minWidth,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color? color;
  final Color? colorText;
  final String? text;
  final Widget? icon;
  final bool border;
  final bool textSmall;
  final double? minWidth;
  final bool isLoading;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    VoidCallback? callback = () {
      if (!isLoading) {
        onPressed();
      }
    };
    if (disabled) {
      callback = null;
    }
    return MaterialButton(
      onPressed: callback,
      color: color,
      disabledColor: Colors.grey,
      shape: RoundedRectangleBorder(
        side: border
            ? const BorderSide(color: AppColors.oliveGreen, width: 2)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(30),
      ),
      minWidth: minWidth ?? MediaQuery.of(context).size.width * .80,
      height: 45,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: colorText,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text ?? '',
                    style: TextStyle(
                        color: colorText,
                        fontSize: textSmall ? 12 : 16,
                        fontWeight: FontWeight.w600),
                  ),
                  if (icon != null) const SizedBox(width: 15),
                  if (icon != null) icon!
                ],
              ),
      ),
    );
  }
}

class AppCircularButton extends StatelessWidget {
  const AppCircularButton({
    required this.onPressed,
    required this.icon,
    required this.colorButton,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final Color colorButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
          backgroundColor: colorButton),
      child: icon,
    );
  }
}

class AppOvalButton extends StatelessWidget {
  const AppOvalButton({
    required this.onPressed,
    required this.text,
    required this.colorButton,
    this.colorText,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color colorButton;
  final Color? colorText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: colorButton,
        elevation: 3,
      ),
      child: Text(
        text,
        style: TextStyle(color: colorText, fontSize: 16),
      ),
    );
  }
}
