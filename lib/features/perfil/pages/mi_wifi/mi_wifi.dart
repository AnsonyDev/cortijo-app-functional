import 'package:cortijo_app/core/data/user_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/wifi.dart';
import 'package:cortijo_app/features/home/widgets/tittle_home.dart';
import 'package:cortijo_app/theme/colors.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:cortijo_app/widgets/app_header.dart';
import 'package:cortijo_app/widgets/my_shimmer/my_shimmer.dart';
import 'package:cortijo_app/widgets/my_spacer/my_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiWifiPage extends StatelessWidget {
  const MiWifiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fillerColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppHeader(isPeril: true),
            const SizedBox(height: 30),
            const TittleHome(tittle: 'Mi wifi'),
            spacerS,
            FutureBuilder<Wifi>(
              future: locator.get<UserRepository>().getWifi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _CardWifi(wifi: snapshot.data!);
                }
                return const MyShimmer(
                  height: 220,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class _CardWifi extends StatelessWidget {
  const _CardWifi({
    required this.wifi,
    Key? key,
  }) : super(key: key);

  final Wifi wifi;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          spacerS,
          _Item(
            title: 'Nombre de la wifi',
            content: wifi.ssid ?? '',
          ),
          spacerS,
          _Item(
            title: 'Contraseña',
            content: wifi.password ?? '',
            icon: IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: wifi.password ?? '')).then((_) {
                  Dialogs.sucess(msg: '¡Contraseña copiado al portapapeles!');
                });
              },
              icon: const Icon(
                Icons.copy_rounded,
                color: AppColors.oliveGreen,
              ),
              splashColor: AppColors.oliveGreen,
              highlightColor: AppColors.oliveGreen70,
              splashRadius: 20,
            ),
          ),
          spacerS,
        ]),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.content, this.icon});

  final String title;
  final String content;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        spacerS,
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.fillerColorOp,
          ),
          child: Row(
            children: [Expanded(child: Text(content)), if (icon != null) icon!],
          ),
        ),
      ],
    );
  }
}
