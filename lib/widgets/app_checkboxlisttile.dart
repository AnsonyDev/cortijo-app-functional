import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppCheckBoxListTile extends StatelessWidget {
  const AppCheckBoxListTile({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.tittle,
  }) : super(key: key);

  final void Function(bool?)? onChanged;
  final bool? value;
  final String tittle;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: onChanged,
      value: value,
      title: Text(tittle),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      checkColor: AppColors.oliveGreen,
      checkboxShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}
