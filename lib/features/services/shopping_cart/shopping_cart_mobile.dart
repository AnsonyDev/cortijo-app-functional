part of shopping_cart_view;

class _ShoppingCartMobile extends StatelessWidget {
  final ShoppingCartViewModel model;

  const _ShoppingCartMobile(this.model);

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

  final ShoppingCartViewModel model;

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
                Text(
                  "${e.price} €",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
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
                    '''El encargo debe realizarse antes de las 15.00h. Las cestas se entregan al día siguiente del encargo. Servicio no disponible en domingos''',
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
                    text: 'Entendido',
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

  final ShoppingCartViewModel model;

  @override
  Widget build(BuildContext context) {

    String? photo = model.product!.photo;
    if(photo == null || photo.isEmpty){
      photo = model.service!.service!.photo!;
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      physics: const BouncingScrollPhysics(),
      children: [
        DescriptionServiceCard(
          img: photo,
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
            'Selecciona la cantidad de cestas',
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
        spacerS,
        AppButton(
          onPressed: () {
            model.addShoppingCar();
            model.previousPage();
          },
          text: "Añadir otra cesta",
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

class _Page3 extends StatelessWidget {
  const _Page3(
    this.model, {
    Key? key,
  }) : super(key: key);

  final ShoppingCartViewModel model;

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
          const Text(
              'La composición de las cestas puede variar ligeramente según la temporada y la disponibilidad de los productos')
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
          text: "Enviar pedido",
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
                    'Te enviaremos un correo con la confirmación de tu perdido',
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
