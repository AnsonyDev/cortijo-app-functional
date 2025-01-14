part of withdrawal_view;

class _WithdrawalMobile extends StatelessWidget {
  final WithdrawalViewModel model;
  final HomeViewModel homeModel;

  const _WithdrawalMobile(this.model, this.homeModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppHeader(),
          spacerS,
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AppTitle(
              text: model.withdrawal.name ?? '',
            ),
          ),
          WithdrawalCard(
            desc: model.withdrawal.name ?? '',
            imgs: model.withdrawal.photos ?? [],
          ),
          WithdrawalInfo(data: model.withdrawal)
        ],
      ),
      bottomNavigationBar: LocalDataRepository().booking == null
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                onPressed: () async => await _dialog(context),
                text: "Reservar",
                color: AppColors.oliveGreen,
                colorText: AppColors.white,
              ),
            )
          : null,
    );
  }

  Future<dynamic> _dialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return CalendarDialog(
          homeModel,
          currentWithdrawal: model.withdrawal,
        );
      },
    );
  }
}
