import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/data/services_repository.dart';
import 'package:cortijo_app/core/locator.dart';
import 'package:cortijo_app/core/models/services.dart';
import 'package:cortijo_app/features/routes/router.gr.dart';

class ServiciosViewModel extends BaseViewModel {
  List<Service> services = [];
  final router = locator<AppRouter>();

  final ServicesRepository _servicesRepository;

  ServiciosViewModel(this._servicesRepository) {
    router.addListener(() {
      if (router.topRoute.name == "ServiciosView") {
        getServices();
      }
    });
  }

  Future<void> getServices() async {
    if (services.isNotEmpty) return;
    busy = true;
    services = await _servicesRepository.getServices();
    busy = false;
  }
}
