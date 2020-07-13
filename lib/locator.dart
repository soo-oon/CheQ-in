import 'package:checkin/services/authentication_service.dart';
import 'package:checkin/services/dialog_service.dart';
import 'package:checkin/services/firestore_service.dart';
import 'package:checkin/services/navigation_service.dart';
import 'package:checkin/services/pushnotification_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => DialogService());
}