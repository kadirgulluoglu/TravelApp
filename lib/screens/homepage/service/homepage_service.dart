import 'package:denemefirebaseauth/screens/homepage/model/homepage_model.dart';
import 'package:denemefirebaseauth/screens/homepage/service/i_homepage_service.dart';

import '../../../services/network_manager.dart';

class HomePageService extends IHomePageService {
  @override
  Future getPlaces() async {
    return await NetworkManager.instance!.dioGet(
      "/8428cf7e-5ce2-4dec-af8d-a0ec2c94c679",
      model: HomePageModel(),
    );
  }
}
