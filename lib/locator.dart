import 'package:get_it/get_it.dart';

import 'screens/homepage/service/homepage_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => HomePageService());
}
