part of perfil_view;

class _PerfilMobile extends StatelessWidget {
  final PerfilViewModel model;

  const _PerfilMobile(this.model);

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(isPeril: true),
            const SizedBox(height: 30),
            const TittleHome(tittle: 'Perfil'),
            CardPerfil(
              icon:
                  SvgPicture.asset('assets/icons/icon-settings.svg', width: 28),
              tittle: 'Configuración de la cuenta',
              items: [
                ItemCardPerfil(
                  'Información personal',
                  () => router.navigate(const PersonalInformationRoute()),
                ),
                ItemCardPerfil(
                  'Mi wifi',
                  () => router.navigate(const MiWifiRoute()),
                ),
                ItemCardPerfil(
                    'Transacciones',
                    () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const w.WalletView(isTransactions: true);
                        }))),
                ItemCardPerfil(
                  'Notificaciones',
                  () => router.navigate(const AvisosRouter()),
                ),
              ],
            ),
            CardPerfil(
              icon: SvgPicture.asset('assets/icons/icon-ayuda.svg', width: 28),
              tittle: 'Ayuda',
              items: [
                ItemCardPerfil(
                  'Preguntas frecuentes',
                  () => router.navigate(const FaqsRoute()),
                ),
                ItemCardPerfil(
                  'Contacto',
                  () => router.navigate(const ContactsRoute()),
                ),
              ],
            ),
            model.busy
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: MyShimmer(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 228,
                    ),
                  )
                : CardPerfil(
                    icon: SvgPicture.asset('assets/icons/icon-legal.svg',
                        width: 26),
                    tittle: 'Legal',
                    items: model.legal.map((e) {
                      return ItemCardPerfil(
                        e.title ?? '',
                        () => router.navigate(LegalRoute(legal: e)),
                      );
                    }).toList()),

            /// ABRIR y CERRAR porton del retiro
            if (LocalDataRepository().booking != null)
              Row(
                children: [
                  const SizedBox(width: 20),
                  Expanded(
                      child: AppButton(
                    onPressed: model.openGate,
                    text: "Abrir portón",
                    isLoading: model.openingGate,
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: AppButton(
                    onPressed: model.closeGate,
                    isLoading: model.closingGate,
                    text: "Cerrar portón",
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  )),
                  const SizedBox(width: 20),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: AppButton(
                onPressed: () async {
                  if(await showDialogMessage(context)){
                    model.deleteUser();
                  }
                },
                isLoading: model.loadDelete,
                text: 'Eliminar cuenta',
                color: AppColors.white,
                colorText: AppColors.oliveGreen,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              child: AppButton(
                onPressed: model.logOut,
                text: 'Cerrar sesión',
                color: AppColors.white,
                colorText: AppColors.oliveGreen,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showDialogMessage(BuildContext context) async {
    return await showDialog(
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
                const AppTitle(text: 'Eliminar cuenta'),
                spacerS,
                SizedBox(
                  width: MediaQuery.of(context).size.width * .50,
                  child: const Text(
                    '''¿Confirmas que deseas eliminar tu cuenta? Se borrará de forma permanente''',
                    textAlign: TextAlign.center,
                  ),
                ),
                spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    text: 'Cancelar',
                    color: AppColors.oliveGreen,
                    colorText: AppColors.white,
                  ),
                ),spacerS,
                SizedBox(
                  height: 35,
                  child: AppButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
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
