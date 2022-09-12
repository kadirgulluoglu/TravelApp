import 'package:denemefirebaseauth/screens/homepage/model/homepage_model.dart';
import 'package:denemefirebaseauth/screens/homepage/service/i_homepage_service.dart';

import '../../../services/network_manager.dart';

class HomePageService extends IHomePageService {
  @override
  Future getPlaces() async {
    return await NetworkManager.instance!.dioGet(
      "/f3e2bc93-34e2-4e64-bac5-a513c46078d3",
      model: HomePageModel(),
    );
  }
}
