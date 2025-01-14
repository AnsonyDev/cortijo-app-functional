import 'dart:ui';

import 'package:cortijo_app/core/models/withdrawals.dart';
import 'package:cortijo_app/features/home/views/home_view_model.dart';
import 'package:cortijo_app/features/home/widgets/webview.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/my_calendar.dart';
import 'package:cortijo_app/widgets/my_dropdown_button/my_drop_down_button.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import '../../../core/services/shared_preferences.dart';
import '../../../theme/colors.dart';
import '../../../widgets/app_header.dart';
import '../../check_in/checkin_view.dart';
import 'booking_widget.dart';

class CheckInCheckOutWidget extends StatefulWidget {
  const CheckInCheckOutWidget(
    this.model, {
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  State<CheckInCheckOutWidget> createState() => _CheckInCheckOutWidgetState();
}

class _CheckInCheckOutWidgetState extends State<CheckInCheckOutWidget> {
  bool visible = true;

  final today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/imgs/BackGroundHome.png',
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(color: AppColors.blackTransparent),
            ),
            Positioned(
              bottom: 0,
              height: 200,
              right: 0,
              left: 0,
              child: Image.asset('assets/imgs/gradient.png', fit: BoxFit.fill),
            ),
            Column(
              children: [
                Visibility(
                  visible: LocalDataRepository().isLogged,
                  child: const AppHeader(isHome: true),
                ),
                const Spacer(),
                widget.model.loadingBooking
                    ? const MyShimmer(
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                        height: 200,
                      )
                    : widget.model.bookingConfirmed == null
                        ? checkInWidget(context)
                        : today.isAfter(
                                widget.model.bookingConfirmed!.checkOut!)
                            ? checkInWidget(context)
                            : BookingWidget(widget.model.bookingConfirmed!,
                                hasRegisterGuestComplete: widget.model
                                    .hasRegisterGuestComplete, onCheckIn: () {
                                Navigator.of(context).push<bool>(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CheckInView(
                                          booking:
                                              widget.model.bookingConfirmed!);
                                    },
                                  ),
                                ).then((value) {
                                  // if (value ?? false) {
                                  widget.model.checkBooking();
                                  // }
                                });
                              }),
              ],
            )
          ],
        ));
  }

  Widget checkInWidget(BuildContext context) {
    return Visibility(
      visible: LocalDataRepository().isLogged,
      child: AnimatedOpacity(
        opacity: visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.fillerColor.withOpacity(0.4),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Check in',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          AppButton(
                            onPressed: () {
                              if (widget.model.withdrawals.isEmpty) {
                                return;
                              }
                              setState(() {
                                visible = false;
                              });
                              _dialog(context).then((value) {
                                setState(() {
                                  visible = true;
                                });
                              });
                            },
                            text: 'Seleccionar fecha',
                            textSmall: true,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Check out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppButton(
                            onPressed: () {
                              if (widget.model.withdrawals.isEmpty) {
                                return;
                              }
                              setState(() {
                                visible = false;
                              });
                              _dialog(context).then((value) {
                                setState(() {
                                  visible = true;
                                });
                              });
                            },
                            text: 'Seleccionar fecha',
                            textSmall: true,
                            color: AppColors.white,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                AppButton(
                  onPressed: () {
                    /*visible = false;
                              context.router
                                  .push(const CheckInView())
                                  .then((value) {
                                _dialog(context).then((value) {
                                  visible = true;
                                });
                              });*/
                    if (widget.model.withdrawals.isEmpty) {
                      return;
                    }
                    setState(() {
                      visible = false;
                    });
                    widget.model.withdrawalsSelected = null;
                    _dialog(context).then((value) {
                      setState(() {
                        visible = true;
                      });
                    });
                  },
                  text: 'Reservar',
                  colorText: AppColors.white,
                  color: AppColors.oliveGreen,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> _dialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return CalendarDialog(widget.model);
      },
    );
  }
}

class CalendarDialog extends StatefulWidget {
  const CalendarDialog(
    this.model, {
    this.currentWithdrawal,
    Key? key,
  }) : super(key: key);

  final HomeViewModel model;
  final Withdrawal? currentWithdrawal;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  DateTime? checkIn;
  DateTime? checkOut;

  @override
  void initState() {
    if (widget.currentWithdrawal != null) {
      setState(() {
        widget.model.withdrawalsSelected = widget.currentWithdrawal;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        color: Colors.white,
        // height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Check in',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppButton(
                        onPressed: () {
                          // _dialog(context);
                        },
                        text: checkIn != null
                            ? intl.DateFormat.yMd('es').format(checkIn!)
                            : 'Seleccionar fecha',
                        textSmall: true,
                        color: AppColors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Check out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppButton(
                        onPressed: () {
                          // _dialog(context);
                        },
                        text: checkOut != null
                            ? intl.DateFormat.yMd('es').format(checkOut!)
                            : 'Seleccionar fecha',
                        textSmall: true,
                        color: AppColors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
            spacerM,
            Row(
              children: [
                Expanded(
                  child: MyCustomDropdownButton<Withdrawal>(
                      hint: 'Retiro',
                      buttonWidth: double.infinity,
                      dropdownWidth: 310,
                      dropdownItems: widget.model.withdrawals
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(
                                  item.name ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTextStyle.defaultStyle,
                                ),
                              ))
                          .toList(),
                      value: widget.model.withdrawalsSelected,
                      onChanged: (v) => setState(() {
                            widget.model.withdrawalsSelected = v;
                          })),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MyCustomDropdownButton<int>(
                      hint: 'Huespedes',
                      buttonWidth: double.infinity,
                      dropdownWidth: 310,
                      dropdownItems: List.generate(
                          widget.model.withdrawalsSelected
                                  ?.additionalCapacity ??
                              0, (i) {
                        return DropdownMenuItem<int>(
                          value: i,
                          child: Text(
                            (i + 1).toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTextStyle.defaultStyle,
                          ),
                        );
                      }),
                      value: widget.model.guests,
                      onChanged: (v) => setState(() {
                            widget.model.guests = (v!);
                          })),
                )
              ],
            ),
            spacerXs,
            MyCalendar(
              focusedDay: (p0) {},
              endDate: (end) {
                setState(() {
                  checkOut = end;
                });
              },
              startDate: (start) {
                setState(() {
                  checkIn = start;
                });
              },
            ),
            const SizedBox(height: 10),
            AppButton(
              onPressed: () async {
                setState(() {});
                await widget.model
                    .bookingsWithdrawal(
                  checkIn: intl.DateFormat('yyyy-MM-dd').format(checkIn!),
                  checkOut: intl.DateFormat('yyyy-MM-dd').format(checkOut!),
                )
                    .then((v) {
                  if (v != null) {
                    Navigator.of(context).pop();
                    // locator<AppRouter>().pop();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return WebViewPage(url: v);
                    })).then((_) {
                      widget.model.checkBooking();
                    });
                  }
                });
                setState(() {});
              },
              isLoading: widget.model.busy,
              disabled: checkIn == null ||
                  checkOut == null ||
                  widget.model.withdrawalsSelected == null,
              text: 'Reservar',
              colorText: AppColors.white,
              color: AppColors.oliveGreen,
            )
          ],
        ),
      ),
    );
  }
}
