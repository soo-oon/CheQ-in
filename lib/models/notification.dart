class NotificationRisk {
  bool _isDanger = false;
  String _comment = "";

  NotificationRisk(this._isDanger, this._comment);

  set setIsDanger(bool isDanger) => _isDanger = isDanger;
  set setComment(String comment) => _comment = comment;
  bool getIsDanger() => _isDanger;
  String getComment() => _comment;
  //bool get isDanger => _isDanger;
  //String get comment => _comment;
}
