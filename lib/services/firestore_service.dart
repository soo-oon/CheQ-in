import 'dart:async';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _buildingsCollectionReference =
      Firestore.instance.collection('buildings');
  List<Building> buildings;
  final StreamController<List<Building>> _buildingsController =
      StreamController<List<Building>>.broadcast();
  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _buildingsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Building.fromData(snapshot.data))
            .where((mappedItem) => mappedItem.name != null)
            .toList();
        // Add the posts onto the controller
        _buildingsController.add(posts);
      }
    });

    return _buildingsController.stream;
  }

  Future updateBuilding(Building building) async {
    try {
      await _buildingsCollectionReference
          .document(building.id)
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
      return User.fromData(userData.data);
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
            .map((snapshot) => Building.fromData(snapshot.data))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addBuilding(Building building) async {
    try {
      await _buildingsCollectionReference.add(building.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
