import 'package:flutter/material.dart';

import '../welcome_view_model.dart';

class BackgroundWelcome extends StatelessWidget {
  const BackgroundWelcome(
    this.model, {
    Key? key,
  }) : super(key: key);

  final WelcomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          model.backgroundImg,
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned.fill(
          child: Container(color: Colors.black26),
        )
      ],
    );
  }
}
