import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:flutter/material.dart';

class MyCounterWidget extends StatefulWidget {
  const MyCounterWidget({
    this.onTap,
    this.initCount,
    Key? key,
  }) : super(key: key);

  final Function(int)? onTap;
  final int? initCount;

  @override
  State<MyCounterWidget> createState() => _MyCounterWidgetState();
}

class _MyCounterWidgetState extends State<MyCounterWidget> {
  int counter = 1;

  @override
  void initState() {
    counter = widget.initCount ?? 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _button(
          onTap: () {
            if (counter > 1) {
              setState(() {
                counter -= 1;
                widget.onTap!(counter);
              });
            }
          },
          icon: Icons.remove,
        ),
        Container(
          margin: const EdgeInsets.all(10),
          height: 50,
          width: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.oliveGreen,
            shape: BoxShape.circle,
          ),
          child: Text(
            counter.toString(),
            style: AppTextStyle.cardTitleStyle.copyWith(color: Colors.white),
          ),
        ),
        _button(
          onTap: () {
            setState(() {
              counter += 1;
              widget.onTap!(counter);
            });
          },
          icon: Icons.add,
        )
      ],
    );
  }

  InkWell _button({void Function()? onTap, required IconData icon}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: AppColors.oliveGreen70,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
