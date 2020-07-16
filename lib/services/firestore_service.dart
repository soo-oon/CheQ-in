import 'dart:async';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference = Firestore.instance.collection('users');
  final CollectionReference _buildingsCollectionReference = Firestore.instance.collection('buildings');
  final CollectionReference _logsCollectionReference = Firestore.instance.collection('logs');
  final StreamController<List<Building>> _buildingsController = StreamController<List<Building>>.broadcast();

  List<Building> buildings;
  List<Log> logs;

  Stream listenToBuildingsRealTime() {
    _buildingsCollectionReference.snapshots().listen((buildingsSnapshot) {
      if (buildingsSnapshot.documents.isNotEmpty) {
        var buildings = buildingsSnapshot.documents
            .map((snapshot) => Building.fromJson(snapshot.data))
            .where((mappedItem) => mappedItem.name != null)
            .toList();
        _buildingsController.add(buildings);
      }
    });

    return _buildingsController.stream;
  }

  Future updateBuilding(Building building) async {
    try {
      var i = _buildingsCollectionReference.document(building.name).documentID;
      print(building.toJson());
      await _buildingsCollectionReference
          .document(i)
          .updateData(building.toJson());
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromJson(userData.data);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getBuildings() async {
    try {
      var list = await _buildingsCollectionReference.getDocuments();
      if (list.documents.isNotEmpty) {
        return list.documents
            .map((snapshot) => Building.fromJson(snapshot.data))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getLogs() async {
    try {
      var list = await _logsCollectionReference.getDocuments();
      if (list.documents.isNotEmpty) {
        return list.documents
            .map((snapshot) => Log.fromJson(snapshot.data))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
