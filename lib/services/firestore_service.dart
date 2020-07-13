import 'dart:async';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  //final CollectionReference _buildingsCollectionReference =Firestore.instance.collection('buildings');

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
/*
  Future createBuilding(Building building) async {
    try {
      await _buildingsCollectionReference
          .document(building.id)
          .setData(building.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getBuilding(String bid) async {
    try {
      var buildingData =
          await _buildingsCollectionReference.document(bid).get();
      return User.fromData(buildingData.data);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }*/
}
