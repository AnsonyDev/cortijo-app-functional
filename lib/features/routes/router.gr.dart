// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:auto_route/empty_router_widgets.dart' as _i4;
import 'package:flutter/material.dart' as _i23;

import '../../core/models/booking.dart' as _i24;
import '../../core/models/legal.dart' as _i25;
import '../../core/models/withdrawals.dart' as _i26;
import '../check_in/checkin_view.dart' as _i7;
import '../home/views/home_view.dart' as _i5;
import '../home/views/home_view_model.dart' as _i27;
import '../intro_authentication/intro_authentication_view.dart' as _i2;
import '../notices/notices_view.dart' as _i20;
import '../perfil/pages/contacts/contacts_page.dart' as _i12;
import '../perfil/pages/fags/fags_page.dart' as _i11;
import '../perfil/pages/legal/legal_page.dart' as _i10;
import '../perfil/pages/mi_wifi/mi_wifi.dart' as _i8;
import '../perfil/pages/personal_information/personal_information_page.dart'
    as _i9;
import '../perfil/perfil_view.dart' as _i6;
import '../route.dart' as _i3;
import '../services/bike_rental/bike_rental_view.dart' as _i17;
import '../services/breakfast_basket/breakfast_basket_view.dart' as _i15;
import '../services/cleaning/cleaning_view.dart' as _i19;
import '../services/laundry/laundry_view.dart' as _i18;
import '../services/services_view.dart' as _i14;
import '../services/shopping_cart/shopping_cart_view.dart' as _i16;
import '../wallet/wallet_view.dart' as _i21;
import '../welcome/welcome_view.dart' as _i1;
import '../withdrawal_detail/withdrawal_view.dart' as _i13;

class AppRouter extends _i22.RootStackRouter {
  AppRouter([_i23.GlobalKey<_i23.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i22.PageFactory> pagesMap = {
    WelcomeView.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.WelcomeView(),
      );
    },
    IntroAuthenticationRouter.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<IntroAuthenticationRouterArgs>(
          orElse: () => IntroAuthenticationRouterArgs(
                  logIn: pathParams.getBool(
                'logIn',
                false,
              )));
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.IntroAuthenticationView(
          logIn: args.logIn,
          key: args.key,
        ),
      );
    },
    RouterRoute.name: (routeData) {
      final args = routeData.argsAs<RouterRouteArgs>(
          orElse: () => const RouterRouteArgs());
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.RouterPage(
          key: args.key,
          showWelcomeMessage: args.showWelcomeMessage,
        ),
      );
    },
    HomeRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    ServiciosRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    AvisosRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    WalletRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmptyRouterPage(),
      );
    },
    HomeView.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
    PerfilView.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.PerfilView(),
      );
    },
    CheckInView.name: (routeData) {
      final args = routeData.argsAs<CheckInViewArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.CheckInView(
          booking: args.booking,
          key: args.key,
        ),
      );
    },
    MiWifiRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.MiWifiPage(),
      );
    },
    PersonalInformationRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.PersonalInformationPage(),
      );
    },
    LegalRoute.name: (routeData) {
      final args = routeData.argsAs<LegalRouteArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.LegalPage(
          key: args.key,
          legal: args.legal,
        ),
      );
    },
    FaqsRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.FaqsPage(),
      );
    },
    ContactsRoute.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.ContactsPage(),
      );
    },
    WithdrawalView.name: (routeData) {
      final args = routeData.argsAs<WithdrawalViewArgs>();
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.WithdrawalView(
          key: args.key,
          withdrawal: args.withdrawal,
          homeModel: args.homeModel,
        ),
      );
    },
    ServiciosView.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i14.ServiciosView(),
      );
    },
    BreakfastBasketRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i15.BreakfastBasketView(),
      );
    },
    ShoppingCartRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.ShoppingCartView(),
      );
    },
    BikeRentalRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i17.BikeRentalView(),
      );
    },
    LaundryRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i18.LaundryView(),
      );
    },
    CleaningRouter.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i19.CleaningView(),
      );
    },
    NoticesView.name: (routeData) {
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i20.NoticesView(),
      );
    },
    WalletView.name: (routeData) {
      final args = routeData.argsAs<WalletViewArgs>(
          orElse: () => const WalletViewArgs());
      return _i22.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i21.WalletView(
          key: args.key,
          isTransactions: args.isTransactions,
        ),
      );
    },
  };

  @override
  List<_i22.RouteConfig> get routes => [
        _i22.RouteConfig(
          WelcomeView.name,
          path: '/',
        ),
        _i22.RouteConfig(
          IntroAuthenticationRouter.name,
          path: ':logIn',
        ),
        _i22.RouteConfig(
          RouterRoute.name,
          path: 'routerPage',
          children: [
            _i22.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: RouterRoute.name,
              children: [
                _i22.RouteConfig(
                  HomeView.name,
                  path: '',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  PerfilView.name,
                  path: 'perfil',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  CheckInView.name,
                  path: 'check_in',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  MiWifiRoute.name,
                  path: 'mi_wifi',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  PersonalInformationRoute.name,
                  path: 'personal_information',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  LegalRoute.name,
                  path: 'legal',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  FaqsRoute.name,
                  path: 'faq',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  ContactsRoute.name,
                  path: 'contacts',
                  parent: HomeRouter.name,
                ),
                _i22.RouteConfig(
                  WithdrawalView.name,
                  path: 'withdrawal',
                  parent: HomeRouter.name,
                ),
              ],
            ),
            _i22.RouteConfig(
              ServiciosRouter.name,
              path: 'servicios',
              parent: RouterRoute.name,
              children: [
                _i22.RouteConfig(
                  ServiciosView.name,
                  path: '',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  PerfilView.name,
                  path: 'perfil',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  MiWifiRoute.name,
                  path: 'mi_wifi',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  PersonalInformationRoute.name,
                  path: 'personal_information',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  LegalRoute.name,
                  path: 'legal',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  FaqsRoute.name,
                  path: 'faq',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  ContactsRoute.name,
                  path: 'contacts',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  BreakfastBasketRouter.name,
                  path: 'breakfastBasket',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  ShoppingCartRouter.name,
                  path: 'shoppingCart',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  BikeRentalRouter.name,
                  path: 'bikeRental',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  LaundryRouter.name,
                  path: 'laundry',
                  parent: ServiciosRouter.name,
                ),
                _i22.RouteConfig(
                  CleaningRouter.name,
                  path: 'cleaning',
                  parent: ServiciosRouter.name,
                ),
              ],
            ),
            _i22.RouteConfig(
              AvisosRouter.name,
              path: 'avisos',
              parent: RouterRoute.name,
              children: [
                _i22.RouteConfig(
                  NoticesView.name,
                  path: '',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  PerfilView.name,
                  path: 'perfil',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  MiWifiRoute.name,
                  path: 'mi_wifi',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  PersonalInformationRoute.name,
                  path: 'personal_information',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  LegalRoute.name,
                  path: 'legal',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  FaqsRoute.name,
                  path: 'faq',
                  parent: AvisosRouter.name,
                ),
                _i22.RouteConfig(
                  ContactsRoute.name,
                  path: 'contacts',
                  parent: AvisosRouter.name,
                ),
              ],
            ),
            _i22.RouteConfig(
              WalletRouter.name,
              path: 'wallet',
              parent: RouterRoute.name,
              children: [
                _i22.RouteConfig(
                  WalletView.name,
                  path: '',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  PerfilView.name,
                  path: 'perfil',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  MiWifiRoute.name,
                  path: 'mi_wifi',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  PersonalInformationRoute.name,
                  path: 'personal_information',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  LegalRoute.name,
                  path: 'legal',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  FaqsRoute.name,
                  path: 'faq',
                  parent: WalletRouter.name,
                ),
                _i22.RouteConfig(
                  ContactsRoute.name,
                  path: 'contacts',
                  parent: WalletRouter.name,
                ),
              ],
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.WelcomeView]
class WelcomeView extends _i22.PageRouteInfo<void> {
  const WelcomeView()
      : super(
          WelcomeView.name,
          path: '/',
        );

  static const String name = 'WelcomeView';
}

/// generated route for
/// [_i2.IntroAuthenticationView]
class IntroAuthenticationRouter
    extends _i22.PageRouteInfo<IntroAuthenticationRouterArgs> {
  IntroAuthenticationRouter({
    bool logIn = false,
    _i23.Key? key,
  }) : super(
          IntroAuthenticationRouter.name,
          path: ':logIn',
          args: IntroAuthenticationRouterArgs(
            logIn: logIn,
            key: key,
          ),
          rawPathParams: {'logIn': logIn},
        );

  static const String name = 'IntroAuthenticationRouter';
}

class IntroAuthenticationRouterArgs {
  const IntroAuthenticationRouterArgs({
    this.logIn = false,
    this.key,
  });

  final bool logIn;

  final _i23.Key? key;

  @override
  String toString() {
    return 'IntroAuthenticationRouterArgs{logIn: $logIn, key: $key}';
  }
}

/// generated route for
/// [_i3.RouterPage]
class RouterRoute extends _i22.PageRouteInfo<RouterRouteArgs> {
  RouterRoute({
    _i23.Key? key,
    bool showWelcomeMessage = false,
    List<_i22.PageRouteInfo>? children,
  }) : super(
          RouterRoute.name,
          path: 'routerPage',
          args: RouterRouteArgs(
            key: key,
            showWelcomeMessage: showWelcomeMessage,
          ),
          initialChildren: children,
        );

  static const String name = 'RouterRoute';
}

class RouterRouteArgs {
  const RouterRouteArgs({
    this.key,
    this.showWelcomeMessage = false,
  });

  final _i23.Key? key;

  final bool showWelcomeMessage;

  @override
  String toString() {
    return 'RouterRouteArgs{key: $key, showWelcomeMessage: $showWelcomeMessage}';
  }
}

/// generated route for
/// [_i4.EmptyRouterPage]
class HomeRouter extends _i22.PageRouteInfo<void> {
  const HomeRouter({List<_i22.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class ServiciosRouter extends _i22.PageRouteInfo<void> {
  const ServiciosRouter({List<_i22.PageRouteInfo>? children})
      : super(
          ServiciosRouter.name,
          path: 'servicios',
          initialChildren: children,
        );

  static const String name = 'ServiciosRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class AvisosRouter extends _i22.PageRouteInfo<void> {
  const AvisosRouter({List<_i22.PageRouteInfo>? children})
      : super(
          AvisosRouter.name,
          path: 'avisos',
          initialChildren: children,
        );

  static const String name = 'AvisosRouter';
}

/// generated route for
/// [_i4.EmptyRouterPage]
class WalletRouter extends _i22.PageRouteInfo<void> {
  const WalletRouter({List<_i22.PageRouteInfo>? children})
      : super(
          WalletRouter.name,
          path: 'wallet',
          initialChildren: children,
        );

  static const String name = 'WalletRouter';
}

/// generated route for
/// [_i5.HomeView]
class HomeView extends _i22.PageRouteInfo<void> {
  const HomeView()
      : super(
          HomeView.name,
          path: '',
        );

  static const String name = 'HomeView';
}

/// generated route for
/// [_i6.PerfilView]
class PerfilView extends _i22.PageRouteInfo<void> {
  const PerfilView()
      : super(
          PerfilView.name,
          path: 'perfil',
        );

  static const String name = 'PerfilView';
}

/// generated route for
/// [_i7.CheckInView]
class CheckInView extends _i22.PageRouteInfo<CheckInViewArgs> {
  CheckInView({
    required _i24.Booking booking,
    _i23.Key? key,
  }) : super(
          CheckInView.name,
          path: 'check_in',
          args: CheckInViewArgs(
            booking: booking,
            key: key,
          ),
        );

  static const String name = 'CheckInView';
}

class CheckInViewArgs {
  const CheckInViewArgs({
    required this.booking,
    this.key,
  });

  final _i24.Booking booking;

  final _i23.Key? key;

  @override
  String toString() {
    return 'CheckInViewArgs{booking: $booking, key: $key}';
  }
}

/// generated route for
/// [_i8.MiWifiPage]
class MiWifiRoute extends _i22.PageRouteInfo<void> {
  const MiWifiRoute()
      : super(
          MiWifiRoute.name,
          path: 'mi_wifi',
        );

  static const String name = 'MiWifiRoute';
}

/// generated route for
/// [_i9.PersonalInformationPage]
class PersonalInformationRoute extends _i22.PageRouteInfo<void> {
  const PersonalInformationRoute()
      : super(
          PersonalInformationRoute.name,
          path: 'personal_information',
        );

  static const String name = 'PersonalInformationRoute';
}

/// generated route for
/// [_i10.LegalPage]
class LegalRoute extends _i22.PageRouteInfo<LegalRouteArgs> {
  LegalRoute({
    _i23.Key? key,
    required _i25.Legal legal,
  }) : super(
          LegalRoute.name,
          path: 'legal',
          args: LegalRouteArgs(
            key: key,
            legal: legal,
          ),
        );

  static const String name = 'LegalRoute';
}

class LegalRouteArgs {
  const LegalRouteArgs({
    this.key,
    required this.legal,
  });

  final _i23.Key? key;

  final _i25.Legal legal;

  @override
  String toString() {
    return 'LegalRouteArgs{key: $key, legal: $legal}';
  }
}

/// generated route for
/// [_i11.FaqsPage]
class FaqsRoute extends _i22.PageRouteInfo<void> {
  const FaqsRoute()
      : super(
          FaqsRoute.name,
          path: 'faq',
        );

  static const String name = 'FaqsRoute';
}

/// generated route for
/// [_i12.ContactsPage]
class ContactsRoute extends _i22.PageRouteInfo<void> {
  const ContactsRoute()
      : super(
          ContactsRoute.name,
          path: 'contacts',
        );

  static const String name = 'ContactsRoute';
}

/// generated route for
/// [_i13.WithdrawalView]
class WithdrawalView extends _i22.PageRouteInfo<WithdrawalViewArgs> {
  WithdrawalView({
    _i23.Key? key,
    required _i26.Withdrawal withdrawal,
    required _i27.HomeViewModel homeModel,
  }) : super(
          WithdrawalView.name,
          path: 'withdrawal',
          args: WithdrawalViewArgs(
            key: key,
            withdrawal: withdrawal,
            homeModel: homeModel,
          ),
        );

  static const String name = 'WithdrawalView';
}

class WithdrawalViewArgs {
  const WithdrawalViewArgs({
    this.key,
    required this.withdrawal,
    required this.homeModel,
  });

  final _i23.Key? key;

  final _i26.Withdrawal withdrawal;

  final _i27.HomeViewModel homeModel;

  @override
  String toString() {
    return 'WithdrawalViewArgs{key: $key, withdrawal: $withdrawal, homeModel: $homeModel}';
  }
}

/// generated route for
/// [_i14.ServiciosView]
class ServiciosView extends _i22.PageRouteInfo<void> {
  const ServiciosView()
      : super(
          ServiciosView.name,
          path: '',
        );

  static const String name = 'ServiciosView';
}

/// generated route for
/// [_i15.BreakfastBasketView]
class BreakfastBasketRouter extends _i22.PageRouteInfo<void> {
  const BreakfastBasketRouter()
      : super(
          BreakfastBasketRouter.name,
          path: 'breakfastBasket',
        );

  static const String name = 'BreakfastBasketRouter';
}

/// generated route for
/// [_i16.ShoppingCartView]
class ShoppingCartRouter extends _i22.PageRouteInfo<void> {
  const ShoppingCartRouter()
      : super(
          ShoppingCartRouter.name,
          path: 'shoppingCart',
        );

  static const String name = 'ShoppingCartRouter';
}

/// generated route for
/// [_i17.BikeRentalView]
class BikeRentalRouter extends _i22.PageRouteInfo<void> {
  const BikeRentalRouter()
      : super(
          BikeRentalRouter.name,
          path: 'bikeRental',
        );

  static const String name = 'BikeRentalRouter';
}

/// generated route for
/// [_i18.LaundryView]
class LaundryRouter extends _i22.PageRouteInfo<void> {
  const LaundryRouter()
      : super(
          LaundryRouter.name,
          path: 'laundry',
        );

  static const String name = 'LaundryRouter';
}

/// generated route for
/// [_i19.CleaningView]
class CleaningRouter extends _i22.PageRouteInfo<void> {
  const CleaningRouter()
      : super(
          CleaningRouter.name,
          path: 'cleaning',
        );

  static const String name = 'CleaningRouter';
}

/// generated route for
/// [_i20.NoticesView]
class NoticesView extends _i22.PageRouteInfo<void> {
  const NoticesView()
      : super(
          NoticesView.name,
          path: '',
        );

  static const String name = 'NoticesView';
}

/// generated route for
/// [_i21.WalletView]
class WalletView extends _i22.PageRouteInfo<WalletViewArgs> {
  WalletView({
    _i23.Key? key,
    bool isTransactions = false,
  }) : super(
          WalletView.name,
          path: '',
          args: WalletViewArgs(
            key: key,
            isTransactions: isTransactions,
          ),
        );

  static const String name = 'WalletView';
}

class WalletViewArgs {
  const WalletViewArgs({
    this.key,
    this.isTransactions = false,
  });

  final _i23.Key? key;

  final bool isTransactions;

  @override
  String toString() {
    return 'WalletViewArgs{key: $key, isTransactions: $isTransactions}';
  }
}
