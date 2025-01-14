import 'package:cortijo_app/core/data/wallet_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/core/utils/allow_check_in.dart';
import 'package:cortijo_app/core/utils/is_today.dart';
import 'package:cortijo_app/features/home/widgets/rate_your_stay.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../wallet/wallet_view.dart' as w;
import 'package:intl/intl.dart' as intl;

class BookingWidget extends StatelessWidget {
  const BookingWidget(
    this.booking, {
    required this.onCheckIn,
    required this.hasRegisterGuestComplete,
    this.reservationConfirmed = false,
    Key? key,
  }) : super(key: key);

  final Booking booking;
  final bool hasRegisterGuestComplete;
  final void Function() onCheckIn;
  final bool reservationConfirmed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: reservationConfirmed
          ? null
          : const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!reservationConfirmed)
              const Text('Tu reserva', style: AppTextStyle.h1Style),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Titular',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: Colors.grey)),
                      spacerXs,
                      Text(booking.fullName ?? ''),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Retiro',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: Colors.grey)),
                      spacerXs,
                      Text(booking.withdrawal?.name ?? ''),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Huéspedes',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: Colors.grey)),
                      spacerXs,
                      Row(
                        children: [
                          Text('X${booking.guests}'),
                          spacerS,
                          SvgPicture.asset('assets/icons/icon-perfil.svg')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Divider(thickness: 2),
            Row(
              children: [
                Container(
                  height: 65,
                  width: 65,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(booking.days?.toString() ?? '',
                          style: AppTextStyle.h2Style
                              .copyWith(color: AppColors.white, fontSize: 18)),
                      Text('Noches',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: AppColors.white)),
                    ],
                  ),
                ),
                spacerL,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check in',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: Colors.grey)),
                      spacerXs,
                      Text(intl.DateFormat.yMd('es')
                          .format(booking.checkIn ?? DateTime.now())),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check out',
                          style: AppTextStyle.defaultStyle
                              .copyWith(color: Colors.grey)),
                      spacerXs,
                      Text(intl.DateFormat.yMd('es')
                          .format(booking.checkOut ?? DateTime.now())),
                    ],
                  ),
                ),
              ],
            ),
            spacerS,
            if (allowCheckIn(booking.checkIn!, booking.checkOut!) &&
                !hasRegisterGuestComplete)
              AppButton(
                onPressed: onCheckIn,
                text: 'Confirmar check in',
                colorText: Colors.white,
                color: AppColors.oliveGreen,
                icon: SvgPicture.asset('assets/icons/arrow-checkin.svg'),
              ),
            if (esDiaActual(booking.checkOut!)) _Button(booking: booking),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatefulWidget {
  const _Button({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () {
        if (loading) return;
        setState(() {
          loading = true;
        });
        locator.get<WalletRepository>().getTransactions().then((v) {
          if (v.bookingServices?.isNotEmpty ?? false) {
            setState(() {
              loading = false;
            });
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const w.WalletView(isTransactions: true);
            }));
          } else {
            LocalDataRepository().deleteBooking();
            setState(() {
              loading = false;
            });
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return RateYourStay(widget.booking);
                });
          }
        });
      },
      text: 'Confirmar check out',
      colorText: Colors.white,
      color: AppColors.oliveGreen,
      icon: SvgPicture.asset('assets/icons/arrow-checkout.svg'),
      isLoading: loading,
    );
  }
}
