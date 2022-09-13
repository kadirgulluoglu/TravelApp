import 'package:denemefirebaseauth/screens/homepage/model/homepage_model.dart';
import 'package:denemefirebaseauth/screens/homepage/service/i_homepage_service.dart';

import '../../../services/network_manager.dart';

class HomePageService extends IHomePageService {
  @override
  Future getPlaces() async {
    return await NetworkManager.instance!.dioGet(
      "/9cfc4f2e-7842-4b7a-89b3-a8c85e8bdf82",
      model: HomePageModel(),
    );
  }
}
