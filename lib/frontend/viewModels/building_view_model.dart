import 'package:checkin/models/models.dart';
import 'package:checkin/services/services.dart';

class BuildingViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  bool isAdmin = false;
  List<Building> _buildings;
  List<Building> get buildings => _buildings;
  init() {
    if (currentUser.userRole == "Admin") isAdmin = true;
    listenToPosts();
  }

  Future sendPush(String title, String body) async {
    setBusy(true);
    await _pushNotificationService.sendNotificationMessage(title, body);
    setBusy(false);
  }
  // void enterLog(String buildingName) {
  //   setBusy(true);
  //   for (var building in buildings) {
  //     if (building.name == buildingName) {
  //       if (building.logs == null) {
  //         building.logs = [];
  //       }
  //       var f = new DateFormat('yyyy-MM-dd hh:mm');

  //       building.logs.add(Log(userName: currentUser.fullName, time: f.format(DateTime.now())));
  //       _firestoreService.updateBuilding(building);
  //     }
  //   }
  //   setBusy(false);
  // }

  void listenToPosts() {
    setBusy(true);

    _firestoreService.listenToBuildingsRealTime().listen((postsData) {
      List<Building> updatedPosts = postsData;
      if (updatedPosts != null && updatedPosts.length > 0) {
        _buildings = updatedPosts;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  void fetchBuildings() async {
    _buildings = await _firestoreService.getBuildings();
  }

  FirestoreService getFirestoreService() {
    return _firestoreService;
  }
}
