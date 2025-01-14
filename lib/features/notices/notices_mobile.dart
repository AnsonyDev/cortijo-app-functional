part of notices_view;

class _NoticesMobile extends StatelessWidget {
  final NoticesViewModel model;

  const _NoticesMobile(this.model);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppHeader(),
          const SizedBox(height: 15),
          const TittleHome(tittle: 'Avisos'),
          if (model.busy)
            ...List.generate(
                4,
                (_) => const MyShimmer(
                      width: double.infinity,
                      height: 90,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      borderRadius: 15,
                    )),
          if (!model.busy)
            ...List.generate(model.notices.length, (i) {
              return CardNotice(index: i, model: model);
            }),
          NoResultWidget(
            visible: model.notices.isEmpty && !model.busy,
            text: "No tienes avisos",
          ),
        ],
      ),
    );
  }
}
