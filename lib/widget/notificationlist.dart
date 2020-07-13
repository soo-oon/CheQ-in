import 'package:flutter/material.dart';
import '../models/notification.dart';

class NotificationList with ChangeNotifier {
  List<NotificationRisk> _notificationList;
  int index = 0;
  NotificationList(this._notificationList);
  getNotificationList() => _notificationList;
  setNotificationList(List<NotificationRisk> noticeList) =>
      _notificationList = noticeList;
  void addList(NotificationRisk newNotice) {
    _notificationList.add(newNotice);
    notifyListeners(); // 값이 변할 때마다 플러터 프레임워크에 알려줍니다.
  }

  void removeAtList(int index) {
    _notificationList.removeAt(index);
    notifyListeners(); // 값이 변할 때마다 플러터 프레임워크에 알려줍니다.
  }
}
