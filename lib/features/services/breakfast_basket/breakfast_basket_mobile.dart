part of breakfast_basket_view;

class _BreakfastBasketMobile extends StatelessWidget {
  final BreakfastBasketViewModel model;

  const _BreakfastBasketMobile(this.model);

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
                child: AppTitle(
                    text: model.currentPage == 0
                        ? model.service?.service?.name ?? ''
                        : model.product?.name ?? ''),
              ),
              spacerXs,
              Expanded(
                child: PageView(
                  controller: model.controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _Page1(model),
                    _Page2(model),
                    _Page3(model),
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

  final BreakfastBasketViewModel model;

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
                desc: model.service?.service?.dataSheet ?? '',
              ),
        spacerM,
        if (model.busy)
          ...List.generate(
              3,
              (i) => const MyShimmer(
                    height: 125,
                    margin: EdgeInsets.only(bottom: 16),
                  )),
        if (!model.busy)
          ...model.service!.products!.map((e) {
            return ItemCardService(
              children: [
                Text(
                  e.name ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                spacerXs,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .50,
                  child: Text(
                    e.description ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
                spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () => selectService(context, e),
                    text: 'Seleccionar',
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  ),
                ),
                spacerXs,
              ],
            );
          })
      ],
    );
  }

  Future selectService(BuildContext context, Product product) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerM,
                const AppTitle(text: 'Importante'),
                spacerS,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .50,
                  child: const Text(
                    'Tienes hasta las 15.00h para encargar tu cesta de desayuno de mañana. Las cestas del domingo deberás encargarlas el sábado antes de las 11.00h',
                    textAlign: TextAlign.center,
                  ),
                ),
                spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      model.product = product;
                      model.selectItem(model.items.last);
                      model.nextPage();
                    },
                    text: 'Seleccionar',
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  ),
                ),
                spacerM,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Page2 extends StatelessWidget {
  const _Page2(this.model, {Key? key}) : super(key: key);

  final BreakfastBasketViewModel model;

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
          const Text(
            'Contenido',
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerXs,
          ...model.product!.dataSheet!.map((e) => Text(' • $e')).toList(),
        ]),
        ItemCardService(children: [
          const Text(
            'Selecciona la cantidad de desayunos',
            textAlign: TextAlign.center,
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerXs,
          Center(
            child: MyCounterWidget(
              initCount: model.itemSelected?.amount,
              onTap: (i) {
                model.quantity(i);
              },
            ),
          ),
        ]),
        ItemCardService(
          children: [
            const Text(
              'Selecciona la fecha en que quieres tu cesta',
              textAlign: TextAlign.center,
              style: AppTextStyle.cardTitleStyle,
            ),
            MyCalendar(
              initDate:
                  model.date != null ? DateTime.tryParse(model.date!) : null,
              focusedDay: (date) {
                model.date = intl.DateFormat('yyyy-MM-dd').format(date!);
              },
              isRangeDate: false,
              endDate: (p0) {},
              startDate: (p0) {},
            ),
          ],
        ),
        ItemCardService(
          children: [
            const Text(
              'Selecciona cuándo deseas la entrega',
              textAlign: TextAlign.center,
              style: AppTextStyle.cardTitleStyle,
            ),
            StringRadioButtons<Timezone>(
              initOption: model.timezone,
              options: model.service!.timezones!.map((e) => e).toList(),
              onSelectionChanged: (timezone) {
                model.timezone = timezone;
              },
            ),
          ],
        ),
        spacerS,
        AppButton(
          onPressed: () {
            model.addBreakfast();
            model.previousPage();
          },
          text: "Añadir otro desayuno",
          color: Colors.white,
          colorText: AppColors.oliveGreen,
          icon: const Icon(Icons.add_circle, color: AppColors.oliveGreen),
        ),
        spacerS,
        AppButton(
          onPressed: () {
            model.nextPage();
          },
          disabled: model.date == null || model.timezone == null,
          text: "Continuar",
          color: AppColors.oliveGreen,
          colorText: Colors.white,
        ),
        spacerM,
      ],
    );
  }
}

class _Page3 extends StatelessWidget {
  const _Page3(
    this.model, {
    Key? key,
  }) : super(key: key);

  final BreakfastBasketViewModel model;

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
        ...model.items
            .map(
              (e) => ItemCardService(children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        e.name ?? '',
                        style: AppTextStyle.cardTitleStyle,
                      ),
                    ),
                    Text(
                      "${e.price} €",
                      style: AppTextStyle.cardTitleStyle,
                    ),
                  ],
                ),
                spacerXs,
                Row(
                  children: [
                    const Expanded(child: Text('Cantidad')),
                    Text('X${e.amount}'),
                    AppCircularButton(
                      onPressed: () {
                        model.itemSelected = e;
                        model.previousPage();
                      },
                      icon: SvgPicture.asset("assets/icons/icon-edit.svg"),
                      colorButton: AppColors.fillerColor,
                    )
                  ],
                ),
                spacerXs,
                Row(
                  children: [
                    const Expanded(child: Text('Total')),
                    Text("${(e.price! * e.amount)} €"),
                  ],
                ),
              ]),
            )
            .toList(),
        ItemCardService(children: [
          const Text(
            'Fecha y hora',
            style: AppTextStyle.cardTitleStyle,
          ),
          spacerXs,
          Row(
            children: [
              Expanded(
                  child: Text(
                      '${model.date ?? ''} • ${model.timezone!.toString()}')),
              AppCircularButton(
                onPressed: model.previousPage,
                icon: SvgPicture.asset("assets/icons/icon-edit.svg"),
                colorButton: AppColors.fillerColor,
              )
            ],
          ),
        ]),
        ItemCardService(children: [
          const Text(
            'Observaciones',
            style: AppTextStyle.cardTitleStyle,
          ),
          // spacerXs,
          TextField(
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintMaxLines: 2,
              hintText:
                  'Déjanos saber si hay algo que debamos considerar en tu pedido.',
            ),
            onChanged: model.observations,
          )
        ]),
        ItemCardService(children: [
          Row(
            children: const [
              Icon(Icons.error, color: AppColors.red),
              spacerXs,
              Text(
                'Importante',
                style: AppTextStyle.cardTitleStyle,
              ),
            ],
          ),
          spacerXs,
          Text(model.product?.observations ?? '')
        ]),
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
          text: "Enviar pedido",
          isLoading: model.busy,
          color: AppColors.oliveGreen,
          colorText: Colors.white,
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
