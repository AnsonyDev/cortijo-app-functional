import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:flutter/material.dart';

import '../views/home_view_model.dart';

class HowToGetWidget extends StatelessWidget {
  const HowToGetWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TittleHome(tittle: '¿Cómo llegar?'),
        InkWell(
          onTap: () => model.howToGet(),
          child: Container(
            height: 200,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              'assets/imgs/mapa.png',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
