import 'package:auto_route/auto_route.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';
import 'package:cortijo_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/locator.dart';
import 'package:flutter/material.dart';
import 'core/services/push_notifications.dart';
import 'firebase_options.dart';
import 'widgets/no_scale_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await LocalDataRepository().initPrefs();
  await LocatorInjector.setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationsProvider().initNotifications();

  runApp(const MainApplication());
}

class MainApplication extends StatefulWidget {
  const MainApplication({super.key});

  @override
  State<MainApplication> createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  late AppRouter router;

  @override
  void initState() {
    router = locator<AppRouter>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LocalDataRepository().isLogged) {
        router.pushAndPopUntil(
          RouterRoute(),
          predicate: (_) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Retiros',
      routerDelegate: AutoRouterDelegate(router),
      routeInformationParser: router.defaultRouteParser(),
      scaffoldMessengerKey: scaffoldKey,
      useInheritedMediaQuery: false,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      builder: (context, child) {
        return NoScaleTextWidget(
          child: child!,
        );
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
      ],
    );
  }
}
