import 'package:cortijo_app/core/data/user_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/fags.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const AppHeader(),
              const SizedBox(height: 15),
              const TittleHome(tittle: 'Preguntas frecuentes'),
              FutureBuilder(
                  future: locator<UserRepository>().getFaqs(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          3,
                          (_) => const MyShimmer(
                            margin: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            height: 60,
                            borderRadius: 25,
                          ),
                        ),
                      );
                    } else {
                      final data = snapshot.data;
                      if (data == null) {
                        return const SizedBox();
                      }
                      return Column(
                          children: data.map((e) => _faqsItem(e)).toList());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _faqsItem(Faqs faqs) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(25),
        child: ExpansionTile(
          maintainState: true,
          collapsedBackgroundColor: Colors.white,
          trailing: const Icon(Icons.arrow_drop_down_circle_sharp),
          title: Text(
            faqs.question ?? '',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.white,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            Text(
              faqs.answer ?? '',
              style: AppTextStyle.cardContentStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
