import 'dart:async';

import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/requests_repository.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/data/withdrawals_repository.dart';
import 'package:cortijo_app/core/models/booking.dart';
import 'package:cortijo_app/core/models/services.dart';
import 'package:cortijo_app/core/models/withdrawals.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';
import 'package:logger/logger.dart';
import 'package:video_player/video_player.dart';
import 'package:map_launcher/map_launcher.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    this._withdrawalsRepository,
    this._requestsRepository,
    this._servicesRepository,
  );

  final WithdrawalsRepository _withdrawalsRepository;
  final RequestsRepository _requestsRepository;
  final ServicesRepository _servicesRepository;

  VideoPlayerController videoController = VideoPlayerController.asset(
    'assets/mp4/video.mp4',
    videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
  );

  List<Withdrawal> withdrawals = [];
  List<Service> services = [];
  bool loadingServices = false;
  bool loadingBooking = false;
  Withdrawal? _withdrawalsSelected;
  int _guests = 0;
  Booking? bookingConfirmed;
  List<Booking>? bookingsConfirm = [];
  bool hasRegisterGuestComplete = false;

  List<TouristInformationClass> touristInformation = [
    TouristInformationClass(
      "¿Dónde comer?",
      "assets/imgs/info1.png",
      "https://www.tripadvisor.es/Restaurants-g229461-Arcos_de_la_Frontera_Costa_de_la_Luz_Andalucia.html",
    ),
    TouristInformationClass(
      "¿Qué hacer?",
      "assets/imgs/info2.png",
      "https://www.turismoarcos.es/que-hacer-en-arcos-de-la-frontera/",
    ),
    TouristInformationClass(
      "¿Qué ver en la región?",
      "assets/imgs/info3.png",
      "https://www.cadizturismo.com/es",
    ),
  ];

  Future<void> getWithdrawals() async {
    // if (!LocalDataRepository().isLogged) return;
    busy = true;
    try {
      withdrawals = await _withdrawalsRepository.getWithdrawals();
    } catch (e) {
      Logger().e('ERROR ${e.toString()}');
    }
    busy = false;
  }

  set withdrawalsSelected(Withdrawal? w) {
    _withdrawalsSelected = w;
    notifyListeners();
  }

  Withdrawal? get withdrawalsSelected => _withdrawalsSelected;

  set guests(int? i) {
    _guests = i!;
    notifyListeners();
  }

  int? get guests => _guests;

  Future<void> howToGet() async {
    final availableMaps = await MapLauncher.installedMaps;
    // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

    await availableMaps.first.showMarker(
      coords: Coords(36.73751329704683, -5.736463153051116),
      title: "Cortijo Los Agustinos",
    );
  }

  //      https://open.spotify.com/playlist/6hm93VVek2wMos2OtIu1nQ?si=d77af3deb3164561&pt=35226e47fd94a6f245ab8c48360920ec

  Future<void> onInit() async {
    videoController.addListener(() => notifyListeners());
    videoController.initialize();

    await Future.wait([checkBooking(), getServices(), getWithdrawals()]);
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  // CARGAR SERVICIOS DISPONIBLES
  Future<void> getServices() async {
    loadingServices = true;
    notifyListeners();
    services = await _servicesRepository.getServices();
    loadingServices = false;
    notifyListeners();
  }

  // SOLICITAR RESERVACIONES
  Future<String?> bookingsWithdrawal(
      {required String checkIn, required String checkOut}) async {
    busy = true;
    Logger().i(
        "checkIn => $checkIn, checkOut => $checkOut, ID => ${withdrawalsSelected!.id}");
    try {
      var data = await _requestsRepository.bookingsWithdrawal(
        checkIn: checkIn,
        checkOut: checkOut,
        withdrawalId: withdrawalsSelected!.id.toString(),
        guests: _guests + 1,
      );
      Logger().i(data);
      busy = false;
      return data;
    } catch (e) {
      Dialogs.error(msg: e.toString());
      busy = false;
      return null;
    }
  }

// CONSULTA SI EL USUARIO EN SESION TIENE RESERVA CONFIRMADA
  Future<void> checkBooking() async {
    loadingBooking = true;
    notifyListeners();
    try {
      var data = await _requestsRepository.checkBookings();
      if (data.haveBookings) {
        bookingConfirmed = data.booking;
        hasRegisterGuestComplete = data.hasRegisterGuestComplete;
        bookingsConfirm = data.bookingsConfirm;
        notifyListeners();
      }
    } catch (e) {
      log!.i('ERROR ${e.toString()}');
    }
    loadingBooking = false;
    notifyListeners();
  }
}

class TouristInformationClass {
  final String tittle;
  final String img;
  final String url;

  TouristInformationClass(this.tittle, this.img, this.url);
}
