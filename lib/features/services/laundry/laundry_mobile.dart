part of laundry_view;

class _LaundryMobile extends StatelessWidget {
  final LaundryViewModel model;

  const _LaundryMobile(this.model);

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
                        : model.category?.name ?? ''),
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
                    _Page4(model),
                    // _Page4(model),
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

  final LaundryViewModel model;

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
          ...model.service!.categories!.map((e) {
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
                spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () {
                      model.category = e;
                      model.nextPage();
                    },
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
}

class _Page2 extends StatelessWidget {
  const _Page2(this.model, {Key? key}) : super(key: key);

  final LaundryViewModel model;

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
        spacerM,
        ...model.service!.products!
            .where((c) => c.categoryId == model.category!.id)
            .map((e) {
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
                  e.dataSheet!.join(' / '),
                  textAlign: TextAlign.center,
                ),
              ),
              spacerXs,
              SizedBox(
                width: MediaQuery.of(context).size.width * .50,
                child: Text(
                  "${e.price} € por prenda",
                  textAlign: TextAlign.center,
                ),
              ),
              spacerS,
              SizedBox(
                height: 35,
                child: AppButton(
                  onPressed: () {
                    model.product = e;
                    model.selectItem(model.items.last);
                    model.nextPage();
                  },
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
}

class _Page3 extends StatelessWidget {
  const _Page3(this.model, {Key? key}) : super(key: key);

  final LaundryViewModel model;

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
            'Selecciona la cantidad de prendas',
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
              'Selecciona la fecha en que quieras el servicio',
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
              '¿Necesitas un servicio de lavandería exprés?',
              style: AppTextStyle.cardTitleStyle,
            ),
            spacerXs,
            const Text(
              'Solicita nuestro servicio exprés (3 h) de lavandería por un suplemento del 50% del coste del lavando estándar. ',
            ),
            Row(
              children: [
                Expanded(
                  child: AppCheckBoxListTile(
                      onChanged: (v) => model.express = v,
                      value: model.express,
                      tittle: 'Añadir servicio exprés'),
                ),
                Text(
                    '${(model.product!.price! / 2) + (model.product!.price!)} €')
              ],
            )
          ],
        ),
        spacerS,
        AppButton(
          onPressed: () {
            model.addShoppingCar();
            model.previousPage();
          },
          text: "Añadir otras prendas",
          color: Colors.white,
          colorText: AppColors.oliveGreen,
          icon: const Icon(Icons.add_circle, color: AppColors.oliveGreen),
        ),
        spacerS,
        AppButton(
          onPressed: () {
            model.nextPage();
          },
          text: "Continuar",
          disabled: model.date == null,
          color: AppColors.oliveGreen,
          colorText: Colors.white,
        ),
        spacerM,
      ],
    );
  }
}

class _Page4 extends StatelessWidget {
  const _Page4(
    this.model, {
    Key? key,
  }) : super(key: key);

  final LaundryViewModel model;

  @override
  Widget build(BuildContext context) {
    return MyTapToHideKeyboard(
      child: ListView(
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
                      const Expanded(child: Text('Servicio exprés')),
                      Text(model.express! ? 'Si' : 'No'),
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
                      Text(model.express!
                          ? "${((e.price! / 2) + e.price!) * (e.amount)} €"
                          : "${e.price! * e.amount} €"),
                    ],
                  ),
                ]),
              )
              .toList(),
          ItemCardService(children: [
            const Text(
              'Fecha',
              style: AppTextStyle.cardTitleStyle,
            ),
            spacerXs,
            Row(
              children: [
                Expanded(child: Text(model.date ?? '')),
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
            ...model.product!.observations!
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(" • $e"),
                    ))
                .toList(),
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
            isLoading: model.busy,
            text: "Enviar solicitud",
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
      ),
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
