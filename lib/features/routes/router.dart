import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:cortijo_app/features/home/views/home_view.dart';
import 'package:cortijo_app/features/intro_authentication/intro_authentication_view.dart';
import 'package:cortijo_app/features/perfil/pages/contacts/contacts_page.dart';
import 'package:cortijo_app/features/perfil/pages/fags/fags_page.dart';
import 'package:cortijo_app/features/perfil/pages/personal_information/personal_information_page.dart';
import 'package:cortijo_app/features/perfil/perfil_view.dart';
import 'package:cortijo_app/features/route.dart';
import 'package:cortijo_app/features/services/bike_rental/bike_rental_view.dart';
import 'package:cortijo_app/features/services/cleaning/cleaning_view.dart';
import 'package:cortijo_app/features/services/shopping_cart/shopping_cart_view.dart';
import 'package:cortijo_app/features/welcome/welcome_view.dart';
import 'package:cortijo_app/features/withdrawal_detail/withdrawal_view.dart';

import '../check_in/checkin_view.dart';
import '../notices/notices_view.dart';
import '../perfil/pages/legal/legal_page.dart';
import '../perfil/pages/mi_wifi/mi_wifi.dart';
import '../services/breakfast_basket/breakfast_basket_view.dart';
import '../services/laundry/laundry_view.dart';
import '../services/services_view.dart';
import '../wallet/wallet_view.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(
    path: '/',
    page: WelcomeView,
  ),
  AutoRoute(
    path: ':logIn',
    page: IntroAuthenticationView,
    name: 'IntroAuthenticationRouter',
  ),
  AutoRoute(path: 'routerPage', page: RouterPage, children: [
    AutoRoute(
      path: 'home',
      name: 'HomeRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: HomeView),
        AutoRoute(path: 'perfil', page: PerfilView),
        AutoRoute(path: 'check_in', page: CheckInView),
        AutoRoute(path: 'mi_wifi', page: MiWifiPage),
        AutoRoute(path: 'personal_information', page: PersonalInformationPage),
        AutoRoute(path: 'legal', page: LegalPage),
        AutoRoute(path: 'faq', page: FaqsPage),
        AutoRoute(path: 'contacts', page: ContactsPage),
        AutoRoute(path: 'withdrawal', page: WithdrawalView),
      ],
    ),
    AutoRoute(
      path: 'servicios',
      name: 'ServiciosRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: ServiciosView),
        AutoRoute(path: 'perfil', page: PerfilView),
        AutoRoute(path: 'mi_wifi', page: MiWifiPage),
        AutoRoute(path: 'personal_information', page: PersonalInformationPage),
        AutoRoute(path: 'legal', page: LegalPage),
        AutoRoute(path: 'faq', page: FaqsPage),
        AutoRoute(path: 'contacts', page: ContactsPage),
        AutoRoute(
          path: 'breakfastBasket',
          page: BreakfastBasketView,
          name: 'BreakfastBasketRouter',
        ),
        AutoRoute(
          path: 'shoppingCart',
          page: ShoppingCartView,
          name: 'ShoppingCartRouter',
        ),
        AutoRoute(
          path: 'bikeRental',
          page: BikeRentalView,
          name: 'BikeRentalRouter',
        ),
        AutoRoute(
          path: 'laundry',
          page: LaundryView,
          name: 'LaundryRouter',
        ),
        AutoRoute(
          path: 'cleaning',
          page: CleaningView,
          name: 'CleaningRouter',
        ),
      ],
    ),
    AutoRoute(
      path: 'avisos',
      name: 'AvisosRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: NoticesView),
        AutoRoute(path: 'perfil', page: PerfilView),
        AutoRoute(path: 'mi_wifi', page: MiWifiPage),
        AutoRoute(path: 'personal_information', page: PersonalInformationPage),
        AutoRoute(path: 'legal', page: LegalPage),
        AutoRoute(path: 'faq', page: FaqsPage),
        AutoRoute(path: 'contacts', page: ContactsPage),
      ],
    ),
    AutoRoute(
      path: 'wallet',
      name: 'WalletRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', page: WalletView),
        AutoRoute(path: 'perfil', page: PerfilView),
        AutoRoute(path: 'mi_wifi', page: MiWifiPage),
        AutoRoute(path: 'personal_information', page: PersonalInformationPage),
        AutoRoute(path: 'legal', page: LegalPage),
        AutoRoute(path: 'faq', page: FaqsPage),
        AutoRoute(path: 'contacts', page: ContactsPage),
      ],
    ),
  ])
])
class $AppRouter {}
