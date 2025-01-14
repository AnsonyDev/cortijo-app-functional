import 'package:cortijo_app/core/models/withdrawals.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:flutter/material.dart';

class WithdrawalInfo extends StatelessWidget {
  const WithdrawalInfo({required this.data, Key? key}) : super(key: key);
  final Withdrawal data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item("Capacidad:", "${data.capacity} personas"),
              item("Precio semana:", "${data.weekPrice} €"),
              item("Precio fin de semana:", "${data.weekendPrice} €"),
            ]),
      ),
    );
  }

  Widget item(String title, String subTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
            child: Text(
          title,
          style: AppTextStyle.cardContentStyle,
        )),
        Expanded(child: Text(subTitle))
      ],
    );
  }
}
