import 'package:cortijo_app/core/base/base_view_model.dart';
import 'package:cortijo_app/core/models/notices.dart';

import '../../core/data/notices_repository.dart';
import '../../core/locator.dart';
import '../routes/router.gr.dart';

class NoticesViewModel extends BaseViewModel {
  List<Notices> notices = [];
  final router = locator<AppRouter>();

  final NoticesRepository _noticesRepository;

  NoticesViewModel(this._noticesRepository) {
    router.addListener(() {
      if (router.topRoute.name == "NoticesView") {
        getNotices();
      }
    });
  }

  Future<void> getNotices() async {
    busy = true;
    notices = await _noticesRepository.getNotices();
    busy = false;
  }

  void deleteNotice(int i) {
    notices.removeAt(i);
    notifyListeners();
    _noticesRepository.deleteNotices(notices[i].id!);
  }
}
