part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel model;

  const _HomeMobile(this.model);

  @override
  Widget build(BuildContext context) {
    // final today =
    //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return Container(
      color: AppColors.fillerColor,
      child: RefreshIndicator(
        onRefresh: () => model.checkBooking(),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            CheckInCheckOutWidget(model),
            const SizedBox(height: 20),
            if (model.bookingsConfirm?.isNotEmpty ?? false)
              BookingsConfirmWidget(model),

            // if (model.bookingConfirmed != null &&
            //     !today.isAfter(model.bookingConfirmed?.checkOut ?? today))
            //   const NotDisturbetWidget(),
            const SizedBox(height: 20),
            WithdrawalsWidget(model),
            const SizedBox(height: 20),
            ServicesCortijosWidget(model),
            const SizedBox(height: 20),
            KnowUsWidget(model),
            const SizedBox(height: 20),
            const PlaylistCortijo(),
            const SizedBox(height: 20),
            HowToGetWidget(model),
            const SizedBox(height: 20),
            TouristInformation(model),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class NotDisturbetWidget extends StatefulWidget {
  const NotDisturbetWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotDisturbetWidget> createState() => _NotDisturbetWidgetState();
}

class _NotDisturbetWidgetState extends State<NotDisturbetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // WelcomeBreakfast(),
        spacerM,
        ConfirmationSliderWidget(),
        spacerM,
      ],
    );
  }
}

class WelcomeBreakfast extends StatelessWidget {
  const WelcomeBreakfast({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: double.infinity,
      child: Column(children: [
        SvgPicture.asset('assets/icons/icon-tasa.svg'),
        spacerS,
        const Text(
          '¡Disfruta tu desayuno de bienvenida!',
          style: AppTextStyle.cardTitleStyle,
          textAlign: TextAlign.center,
        ),
        spacerXs,
        const Text(
          'Recuerda que en tu primer día de estancia cuentas con un desayuno de cortesía por parte de Cortijo.',
          style: AppTextStyle.cardContentStyle,
          textAlign: TextAlign.center,
        ),
        spacerS,
        Text(
          'x2 Desayuno Frances',
          style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        spacerXs,
        Text(
          'x1 Desayuno mediterráneo',
          style: AppTextStyle.cardTitleStyle.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}

class ConfirmationSliderWidget extends StatefulWidget {
  const ConfirmationSliderWidget({super.key});

  @override
  State<ConfirmationSliderWidget> createState() =>
      _ConfirmationSliderWidgetState();
}

class _ConfirmationSliderWidgetState extends State<ConfirmationSliderWidget> {
  bool notDisturb = false;
  bool busy = false;
  late AppRouter router;

  @override
  void initState() {
    super.initState();

    final user = LocalDataRepository().user;
    notDisturb = user?.notDisturb == '1';
  }

  @override
  Widget build(BuildContext context) {
    return ConfirmationSlider(
      onConfirmation: () async {
        if (busy) return;
        setState(() {
          notDisturb = !notDisturb;
          busy = true;
        });
        await locator<ServicesRepository>()
            .notDisturb(notDisturb ? 1 : 0)
            .then((value) {
          setState(() {
            busy = false;
          });
        });
      },
      backgroundColor: notDisturb ? Colors.black : Colors.white,
      foregroundColor: notDisturb ? Colors.white : Colors.black,
      iconColor: notDisturb ? Colors.black : Colors.white,
      text: 'Modo no molestar',
      sliderButtonContent: Icon(
          notDisturb ? Icons.close : Icons.arrow_forward_rounded,
          color: notDisturb ? Colors.black : Colors.white),
      width: MediaQuery.of(context).size.width * .90,
      height: 55,
      textStyle: AppTextStyle.h2Style.copyWith(
        fontSize: 18,
        color: notDisturb ? Colors.white : Colors.black,
      ),
    );
  }
}
