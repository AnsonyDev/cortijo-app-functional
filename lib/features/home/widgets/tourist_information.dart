import 'package:cortijo_app/features/home/views/home_view_model.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'tittle_home.dart';

class TouristInformation extends StatelessWidget {
  const TouristInformation(
    this.model, {
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TittleHome(tittle: 'Informacíon Turistica'),
        ...model.touristInformation.map((value) {
          return GestureDetector(
            onTap: () => launchUrlString(value.url),
            child: Container(
                height: 200,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(value.img), fit: BoxFit.cover)),
                child: Center(
                    child: Text(
                  value.tittle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontFamily: 'Quiza pro',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
          );
        }).toList(),
      ],
    );
  }
}
