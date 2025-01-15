import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/tuya_repository.dart';
import 'package:cortijo_app/core/data/user_repository.dart';
import 'package:cortijo_app/core/models/legal.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:cortijo_app/widgets/app_dialogs.dart';

import '../../core/locator.dart';
import '../routes/router.gr.dart';

class PerfilViewModel extends BaseViewModel {
  final UserRepository _userRepository;
  final TuyaRepository _tuyaRepository;
  List<Legal> legal = const [];
  bool openingGate = false;
  bool closingGate = false;

  bool _loadDelete = false;
  bool get loadDelete => _loadDelete;
  set loadDelete(bool value) { _loadDelete = value; notifyListeners(); }

  PerfilViewModel(this._userRepository, this._tuyaRepository);

  Future logOut() async {
    await LocalDataRepository().logOut();
    locator<AppRouter>().pushAndPopUntil(
      const WelcomeView(),
      predicate: (_) => false,
    );
  }

  Future<void> onInit() async {
    busy = true;
    legal = await _userRepository.getLegal();
    busy = false;
  }

  Future<void> openGate() async {
    openingGate = true;
    notifyListeners();
    await _tuyaRepository.openGate().then((value) {
      if (value) {
        Dialogs.sucess(msg: "Abriendo portón");
      } else {
        Dialogs.error(msg: "Ocurrio un error");
      }
    });
    openingGate = false;
    notifyListeners();
  }

  Future<void> closeGate() async {
    closingGate = true;
    notifyListeners();
    await _tuyaRepository.closeGate().then((value) {
      if (value) {
        Dialogs.sucess(msg: "Cerrando portón");
      } else {
        Dialogs.error(msg: "Ocurrio un error");
      }
    });
    closingGate = false;
    notifyListeners();
  }

  Future<void> deleteUser() async {
    loadDelete = true;
    try{
      await _tuyaRepository.deleteCount();
      await LocalDataRepository().logOut();
      loadDelete = false;
      locator<AppRouter>().pushAndPopUntil(
        const WelcomeView(),
        predicate: (_) => false,
      );
    }catch(_){
      loadDelete = false;
    }
  }
}

class ItemCardPerfil {
  String name;
  void Function()? onTap;

  ItemCardPerfil(this.name, this.onTap);
}
