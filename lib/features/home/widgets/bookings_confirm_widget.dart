import 'package:cortijo_app/features/home/widgets/booking_widget.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:flutter/material.dart';

import '../views/home_view_model.dart';
import 'tittle_home.dart';

class BookingsConfirmWidget extends StatelessWidget {
  const BookingsConfirmWidget(this.model, {Key? key}) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TittleHome(tittle: 'Reservas Confirmadas'),
          model.loadingServices
              ? const Expanded(
                  child: MyShimmer(
                    margin: EdgeInsets.all(15),
                    height: 220,
                  ),
                )
              : Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller:
                        PageController(initialPage: 0, viewportFraction: 0.9),
                    children: model.bookingsConfirm!
                        .map((e) => BookingWidget(
                              e,
                              onCheckIn: () {},
                              hasRegisterGuestComplete: true,
                              reservationConfirmed: true,
                            ))
                        .toList(),
                  ),
                )
        ],
      ),
    );
  }
}
