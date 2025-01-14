import 'package:cortijo_app/core/models/legal.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';

class LegalPage extends StatelessWidget {
  final Legal legal;

  const LegalPage({super.key, required this.legal});

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
            TittleHome(tittle: legal.title ?? ''),
            spacerS,
            _Card(legal: legal),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.legal});
  final Legal legal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          spacerS,
          Text(
            legal.title ?? '',
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerS,
          Text(
            legal.description ?? '',
            style: AppTextStyle.cardContentStyle,
          ),
          spacerS,
        ]),
      ),
    );
  }
}
