part of welcome_view;

class _WelcomeMobile extends StatelessWidget {
  final WelcomeViewModel model;

  const _WelcomeMobile(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundWelcome(model),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
                SvgPicture.asset(
                  model.logoWhite,
                  width: 150,
                ),
                const SizedBox(height: 30),
                const Text(
                  'El nuevo concepto de lujo en el\npoético corazón de Andalucía',
                  style: TextStyle(color: AppColors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                AppButton(
                  onPressed: model.goToIntro,
                  color: AppColors.whiteTransparent,
                  text: 'Tu viaje comienza aquí',
                  colorText: AppColors.white,
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: model.goToLogin,
                  text: '¿Ya tienes una cuenta? Inicia sesión',
                  colorText: AppColors.white,
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}
