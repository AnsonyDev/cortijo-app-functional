part of cleaning_view;

class _CleaningMobile extends StatelessWidget {
  final CleaningViewModel model;

  const _CleaningMobile(this.model);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (model.currentPage != 0) {
          model.previousPage();
        }
        return Future.value(model.currentPage == 0);
      },
      child: Scaffold(
          backgroundColor: AppColors.fillerColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppHeader(
                back: model.currentPage != 0 ? model.previousPage : null,
              ),
              spacerS,
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: AppTitle(text: 'Limpieza'),
              ),
              spacerXs,
              Expanded(child: _Page1(model)),
            ],
          )),
    );
  }
}

class _Page1 extends StatelessWidget {
  const _Page1(this.model, {Key? key}) : super(key: key);

  final CleaningViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            physics: const BouncingScrollPhysics(),
            children: [
              model.busy
                  ? const MyShimmer(height: 220)
                  : const DescriptionServiceCard(
                      localImg: 'assets/imgs/Limpieza.png',
                      img: '',
                      desc: 'Hacemos la limpieza por ti',
                    ),
              const Text(
                'Solicita aquí la limpieza de tu habitación. Te avisaremos cuando esté lista. Tienes hasta las 14.00h para solicitar la limpieza; pasada esta hora, se realizará al día siguiente',
                textAlign: TextAlign.justify,
              ),
              spacerM,
              // ItemCardService(
              //   children: [
              //     const Text(
              //       'Selecciona la fecha en que quieres la limpieza',
              //       textAlign: TextAlign.center,
              //       style: AppTextStyle.cardTitleStyle,
              //     ),
              //     // MyCalendar(
              //     //   initDate:
              //     //       model.date != null ? DateTime.tryParse(model.date!) : null,
              //     //   focusedDay: (date) {
              //     //     model.date = intl.DateFormat('yyyy-MM-dd').format(date!);
              //     //   },
              //     //   isRangeDate: false,
              //     //   endDate: (date) {
              //     //     // model.endDate = intl.DateFormat('yyyy-MM-dd').format(date!);
              //     //   },
              //     //   startDate: (date) {
              //     //     // model.startDate = intl.DateFormat('yyyy-MM-dd').format(date!);
              //     //   },
              //     // ),
              //   ],
              // ),
              // ItemCardService(
              //   children: [
              //     const Text(
              //       'Selecciona cuando deseas la entrega',
              //       textAlign: TextAlign.center,
              //       style: AppTextStyle.cardTitleStyle,
              //     ),
              //     StringRadioButtons<CleaningTimeZone>(
              //       initOption: model.timezone,
              //       options: model.timezones.map((e) => e).toList(),
              //       onSelectionChanged: (timezone) {
              //         model.timezone = timezone;
              //       },
              //     ),
              //   ],
              // ),
              spacerS,
            ],
          ),
        ),
        AppButton(
          onPressed: () {
            model.sendRequest().then((value) {
              if (value) {
                _sendTheOrder(context).then((_) {
                  Navigator.pop(context);
                });
              }
            });
          },
          text: "Continuar",
          color: AppColors.oliveGreen,
          colorText: Colors.white,
          // disabled: model.date == null || model.timezone == null,
          isLoading: model.busy,
        ),
        spacerM,
      ],
    );
  }

  Future<dynamic> _sendTheOrder(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerM,
                const AppSubTitle(text: 'Confirmamos tu pedido'),
                spacerS,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .60,
                  child: const Text(
                    'Te enviaremos un correo con la confirmación de tu pedido',
                    textAlign: TextAlign.center,
                  ),
                ),
                spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      // model.titleText = basket.name;
                      // model.nextPage();
                    },
                    text: 'Entendido',
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  ),
                ),
                spacerS,
              ],
            ),
          ),
        );
      },
    );
  }
}
