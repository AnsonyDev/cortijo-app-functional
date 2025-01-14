part of servicios_view;

class _ServiciosMobile extends StatelessWidget {
  final ServiciosViewModel model;

  const _ServiciosMobile(this.model);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppHeader(),
          const SizedBox(height: 15),
          const TittleHome(tittle: 'Servicios'),
          if (model.busy)
            ...List.generate(
                4,
                (i) => const MyShimmer(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: 180,
                    )),
          if (!model.busy && model.services.isNotEmpty) ...[
            CardServiceWidget(
              service: model.services[0],
              onTap: () => ra.AutoRouterX(context).router.push(const BreakfastBasketRouter()),
            ),
            CardServiceWidget(
              service: model.services[1],
              onTap: () => ra.AutoRouterX(context).router.push(const ShoppingCartRouter()),
            ),
            CardServiceWidget(
              service: model.services[2],
              onTap: () => ra.AutoRouterX(context).router.push(const BikeRentalRouter()),
            ),
            CardServiceWidget(
              service: model.services[3],
              onTap: () => ra.AutoRouterX(context).router.push(const LaundryRouter()),
            ),
            // CardServiceCleaning(
            //   service: Service(
            //       photo: 'assets/imgs/Limpieza.png',
            //       name: 'Limpieza',
            //       description: 'Hacemos la limpieza por ti'),
            //   onTap: () => context.router.push(const CleaningRouter()),
            // ),
          ]
        ],
      ),
    );
  }
}
