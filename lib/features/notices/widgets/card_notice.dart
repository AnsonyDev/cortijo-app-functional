import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../theme/colors.dart';
import '../notices_view_model.dart';

// import '../../../theme/colors.dart';
// import '../notices_view_model.dart';

class CardNotice extends StatelessWidget {
  final int index;
  final NoticesViewModel model;

  const CardNotice({
    required this.index,
    required this.model,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Positioned.fill(
            child: Dismissible(
              key: UniqueKey(),
              resizeDuration: const Duration(milliseconds: 100),
              direction: DismissDirection.endToStart,
              dismissThresholds: const {DismissDirection.endToStart: 0.3},
              dragStartBehavior: DragStartBehavior.down,
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  model.deleteNotice(index);
                }
              },
              confirmDismiss: (direction) async {
                return (direction == DismissDirection.endToStart);
              },
              background: Container(
                padding: const EdgeInsets.only(right: 25),
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SvgPicture.asset(
                  'assets/icons/icon-delete.svg',
                  height: 25,
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.oliveGreen),
                      child: SvgPicture.asset('assets/icons/icon-reloj.svg'),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 15, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.notices[index].data ?? ''),
                          const Spacer(),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                timeago.format(model.notices[index].createdAt!,
                                    locale: 'es'),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              )),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
