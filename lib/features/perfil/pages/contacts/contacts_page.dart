import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(isPeril: true),
            const SizedBox(height: 30),
            const TittleHome(tittle: 'Contacto'),
            // const Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 15),
            //   child: Text(
            //       'Lorem ipsum dolor sit amet consectetur. Eget enim euismod magna faucibus viverra.'),
            // ),
            spacerM,
            _item(
                title: 'Email',
                subTitle: 'la@cortijolosagustinos.com',
                icon: SvgPicture.asset(
                  'assets/icons/icon-mail.svg',
                  color: Colors.white,
                ),
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'la@cortijolosagustinos.com',
                  );
                  await launchUrl(emailLaunchUri);
                }),
            spacerS,
            _item(
                title: 'Teléfono',
                subTitle: '+34 685 521 592',
                icon: SvgPicture.asset('assets/icons/icon-call.svg',
                    color: Colors.white),
                onTap: () async {
                  final url = Uri.parse('tel: +34 685 521 592');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _item(
      {required String title,
      required String subTitle,
      required Widget icon,
      required Function onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.cardTitleStyle,
                  ),
                  spacerXs,
                  Text(
                    subTitle,
                    style: AppTextStyle.cardContentStyle,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => onTap.call(),
              borderRadius: BorderRadius.circular(90),
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.oliveGreen,
                ),
                child: icon,
              ),
            )
          ],
        ),
      ),
    );
  }
}
