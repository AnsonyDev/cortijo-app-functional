part of bike_rental_view;

class _BikeRentalMobile extends StatelessWidget {
  final BikeRentalViewModel model;

  const _BikeRentalMobile(this.model);

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
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: AppTitle(text: model.service?.service?.name ?? ''),
              ),
              spacerXs,
              Expanded(
                child: PageView(
                  controller: model.controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _Page1(model),
                    _Page2(model),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class _Page1 extends StatelessWidget {
  const _Page1(this.model, {Key? key}) : super(key: key);

  final BikeRentalViewModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      physics: const BouncingScrollPhysics(),
      children: [
        model.busy
            ? const MyShimmer(height: 220)
            : DescriptionServiceCard(
                img: model.service?.service?.photo ?? '',
                desc: model.service?.service?.description ?? '',
              ),
        spacerM,
        ItemCardService(children: [
          const Text(
            'Selecciona la cantidad de bicicletas',
            textAlign: TextAlign.center,
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerXs,
          Center(
            child: MyCounterWidget(
              onTap: (i) {
                model.quantity(i);
              },
            ),
          ),
        ]),
        ItemCardService(
          children: [
            const Text(
              'Selecciona la fecha en que quieres la bicicleta',
              textAlign: TextAlign.center,
              style: AppTextStyle.cardTitleStyle,
            ),
            MyCalendar(
              focusedDay: (p0) {},
              // isRangeDate: false,
              endDate: (date) {
                model.endDate = intl.DateFormat('yyyy-MM-dd').format(date!);
              },
              startDate: (date) {
                model.startDate = intl.DateFormat('yyyy-MM-dd').format(date!);
              },
            ),
          ],
        ),
        spacerS,
        AppButton(
          onPressed: () {
            model.nextPage();
          },
          text: "Continuar",
          color: AppColors.oliveGreen,
          colorText: Colors.white,
          disabled: model.startDate == null || model.endDate == null,
        ),
        spacerM,
      ],
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2(
    this.model, {
    Key? key,
  }) : super(key: key);

  final BikeRentalViewModel model;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      physics: const BouncingScrollPhysics(),
      children: [
        DescriptionServiceCard(
          img: model.service!.service!.photo!,
          desc: '',
        ),
        ItemCardService(children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  model.items.first.name ?? '',
                  style: AppTextStyle.cardTitleStyle,
                ),
              ),
              Text(
                "${model.items.first.price} €",
                style: AppTextStyle.cardTitleStyle,
              ),
            ],
          ),
          spacerXs,
          Row(
            children: [
              const Expanded(child: Text('Cantidad')),
              Text('X${model.items.last.amount}'),
              AppCircularButton(
                onPressed: model.previousPage,
                icon: SvgPicture.asset("assets/icons/icon-edit.svg"),
                colorButton: AppColors.fillerColor,
              )
            ],
          ),
          spacerXs,
          Row(
            children: [
              const Expanded(child: Text('Total')),
              Text("${(model.items.last.price! * model.items.last.amount)} €"),
            ],
          ),
        ]),
        ItemCardService(children: [
          const Text(
            'Fecha',
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerXs,
          Row(
            children: [
              Expanded(child: Text('${model.startDate} • ${model.endDate}')),
              AppCircularButton(
                onPressed: model.previousPage,
                icon: SvgPicture.asset("assets/icons/icon-edit.svg"),
                colorButton: AppColors.fillerColor,
              )
            ],
          ),
        ]),
        spacerM,
        AppButton(
          onPressed: () async {
            await model.sendRequest().then((value) {
              if (value) {
                _sendTheOrder(context).then((_) {
                  Navigator.pop(context);
                });
              }
            });
          },
          text: "Enviar solicitud",
          color: AppColors.oliveGreen,
          colorText: Colors.white,
          isLoading: model.busy,
        ),
        spacerS,
        AppButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: "Cancelar",
          color: Colors.white,
          colorText: AppColors.oliveGreen,
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
                Text(
                  'Confirmamos tu pre-reserva',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.h2Style.copyWith(fontSize: 20),
                ),
                spacerS,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .60,
                  child: const Text(
                    'Recepción te confirmará tu pre-reserva lo antes posible. Revisa tu área de Avisos',
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
