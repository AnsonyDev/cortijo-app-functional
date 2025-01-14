import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/theme/text_style.dart';
import 'package:cortijo_app/widgets/app_bottons.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:cortijo_app/widgets/app_textfield.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateYourStay extends StatefulWidget {
  const RateYourStay(
    this.booking, {
    Key? key,
  }) : super(key: key);

  final Booking booking;

  @override
  State<RateYourStay> createState() => _RateYourStayState();
}

class _RateYourStayState extends State<RateYourStay> {
  bool loading = false;
  int? stars = 3;
  String? comment;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Valora tu estancia',
              textAlign: TextAlign.center,
              style: AppTextStyle.h2Style,
            ),
            spacerS,
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColors.oliveGreen,
              ),
              onRatingUpdate: (rating) {
                stars = rating.toInt();
              },
            ),
            spacerM,
            const Text(
              "Déjanos saber tu opinión así podremos mejorar la experiencia de Retiros Los Agustinos",
              style: AppTextStyle.defaultStyle,
              textAlign: TextAlign.center,
            ),
            spacerM,
            AppTextField(
              maxLines: 6,
              textInputAction: TextInputAction.newline,
              onChanged: (p) {
                setState(() {
                  comment = p;
                });
              },
              hinText: 'Escribe tus comentarios...',
            ),
            spacerS,
            AppButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                var res = await locator.get<ServicesRepository>().saveReview(
                    withdrawlId: widget.booking.withdrawalId!,
                    rating: stars ?? 3,
                    description: comment ?? '');
                if (res != null) {
                  Dialogs.sucess(msg: res);
                  LocalDataRepository().deleteBooking();
                }
                setState(() {
                  loading = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              color: AppColors.oliveGreen,
              colorText: Colors.white,
              text: 'Enviar',
              // width: double.infinity,
              isLoading: loading,
            ),
          ],
        ),
      ),
    );
  }
}
