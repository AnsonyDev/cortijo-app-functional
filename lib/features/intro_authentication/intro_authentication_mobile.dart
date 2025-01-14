part of intro_view;

class _IntroAuthenticationMobile extends StatefulWidget {
  final IntroAuthanticationViewModel model;
  final bool logIn;

  const _IntroAuthenticationMobile(this.model, {this.logIn = false});

  @override
  State<_IntroAuthenticationMobile> createState() =>
      _IntroAuthenticationMobileState();
}

class _IntroAuthenticationMobileState
    extends State<_IntroAuthenticationMobile> {
  bool didOpenModalBottomSheet = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Builder(builder: (context) {
          if (widget.logIn && didOpenModalBottomSheet) {
            didOpenModalBottomSheet = false;
            Future.delayed(
              const Duration(milliseconds: 10),
              () {
                modalBottomSheet(context, AuthenticationWidget(widget.model));
              },
            );
          }
          return PageView(
            controller: widget.model.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              IntroPag(
                back: widget.model.goBack,
                next: widget.model.nextPage,
                skip: widget.model.skip,
                imgBack: 'assets/imgs/intro-1.png',
                tittle: 'Vive la experiencia y relájate',
                content:
                    '65 hectáreas de olivos y jardines, junto con una piscina infinita de 20 metros donde enamorarte de la hospitalidad andaluza.',
                currentPage: 1,
              ),
              IntroPag(
                back: widget.model.previousPage,
                next: widget.model.nextPage,
                skip: widget.model.skip,
                imgBack: 'assets/imgs/intro-2.png',
                tittle: 'Disfruta de la naturaleza con nuestras bicicletas',
                content:
                    'Recorre las sendas que rodean los Retiros Los Agustinos y descubre el Parque Natural de Los Alcornocales en el que se enmarca nuestra propiedad.',
                currentPage: 2,
              ),
              IntroPag(
                back: widget.model.previousPage,
                next: widget.model.nextPage,
                skip: widget.model.skip,
                imgBack: 'assets/imgs/intro-3.png',
                tittle: 'Acércate a la cultura y gastronomía andaluza',
                content:
                    'Recorre los pueblos blancos y vecinas ciudades de Jerez de la Frontera o Sevilla, descubre la gastronomía y productos de Andalucía.',
                currentPage: 3,
              ),
              IntroFinal(
                back: widget.model.goBack,
                createAccount: SignUp(widget.model),
                accessWithoutCredentials: widget.model.goToHome,
                accessHere: AuthenticationWidget(widget.model),
              )
            ],
          );
        }),
      ),
    );
  }
}
