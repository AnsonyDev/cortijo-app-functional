import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../perfil_view_model.dart';

class CardPerfil extends StatelessWidget {
  const CardPerfil({
    required this.items,
    required this.icon,
    required this.tittle,
    Key? key,
  }) : super(key: key);
  final Widget icon;
  final String tittle;
  final List<ItemCardPerfil> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      icon,
                      const SizedBox(width: 15),
                      Text(
                        tittle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(items.length, (i) {
                    return Column(children: [
                      InkWell(
                        onTap: items[i].onTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(items[i].name)),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: items.length != i + 1,
                        child: const Divider(
                          color: AppColors.grey,
                          height: 1,
                          thickness: 1.5,
                        ),
                      )
                    ]);
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
