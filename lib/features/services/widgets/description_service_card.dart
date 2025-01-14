import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';

class DescriptionServiceCard extends StatelessWidget {
  const DescriptionServiceCard({
    Key? key,
    this.localImg,
    required this.img,
    required this.desc,
  }) : super(key: key);

  final String img;
  final String desc;
  final String? localImg;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 220,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: localImg != null
                ? Image.asset(
                    localImg!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    img,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        spacerS,
        Text(
          desc,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
