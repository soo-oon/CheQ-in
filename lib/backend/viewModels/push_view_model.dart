import 'package:checkin/backend/viewModels/base_model.dart';
import 'package:checkin/services/pushnotification_service.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class PushViewModel extends BaseModel {
  PushNotificationService _pushNotificationService = locator<PushNotificationService>();

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  init() {}

  Future sendPush(String title, String body) async {
    setBusy(true);
    await _pushNotificationService.sendNotificationMessage(title, body);
    setBusy(false);
  }
}
