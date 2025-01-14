import 'package:cortijo_app/widgets/my_network_image.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';

class WithdrawalCard extends StatelessWidget {
  const WithdrawalCard({
    Key? key,
    required this.imgs,
    required this.desc,
  }) : super(key: key);

  final List<String> imgs;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacerS,
        SizedBox(
          width: double.infinity,
          height: 250,
          child: PageView.builder(
              controller: PageController(viewportFraction: 0.9),
              itemCount: imgs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: MyNetworkImage(
                      image: imgs[i],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
        spacerS,
      ],
    );
  }
}
