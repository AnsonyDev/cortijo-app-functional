part of wallet_view;

class _WalletMobile extends StatelessWidget {
  final WalletViewModel model;

  const _WalletMobile(this.model);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppHeader(),
          const SizedBox(height: 15),
          // if (!model.isTransactions) ...[
          //   const TittleHome(tittle: 'Wallet'),
          //   CardQR(model),
          // ],
          const TittleHome(tittle: 'Transacciones'),
          TransaccionesWidget(model),
          if (model.bookingService.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: AppButton(
                color: AppColors.oliveGreen,
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const WebViewPage(url: '', isPayment: true);
                })).then((_) => model.getPin(reloadPin: false)),
                text: "PAGAR",
                colorText: Colors.white,
              ),
            )
        ],
      ),
    );
  }
}
