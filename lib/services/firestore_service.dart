import 'dart:async';
import 'package:checkin/models/building.dart';
import 'package:checkin/models/log.dart';
import 'package:checkin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../models/suggestion.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _buildingsCollectionReference =
      Firestore.instance.collection('buildings');
  final CollectionReference _logsCollectionReference =
      Firestore.instance.collection('logs');
  final CollectionReference _suggestionsCollectionReference =
      Firestore.instance.collection('suggestions');

// Want to know visited building name in visitedviewmodel.
  List<String> visitedBuildingNames = new List<String>();
  List<Building> buildings;

  final StreamController<List<Building>> _buildingsController =
      StreamController<List<Building>>.broadcast();
  final StreamController<List<Log>> _logsController =
      StreamController<List<Log>>.broadcast();
  final StreamController<List<Suggestion>> _suggestionsController =
      StreamController<List<Suggestion>>.broadcast();


  Stream listenToLogsRealTime() {
    _logsCollectionReference.snapshots().listen((logsSnaphots) {
      if (logsSnaphots.documents.isNotEmpty) {
        var logs = logsSnaphots.documents
            .map((snapshot) => Log.fromJson(snapshot.data))
            .toList();
        _logsController.add(logs);
      }
    });
    
    return _logsController.stream;
  }

  Stream listenToBuildingsRealTime() {
    // Register the handler for when the posts data changes
    _buildingsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Building.fromJson(snapshot.data))
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

  void visitedBuildings(String buildingName) {
    if (!visitedBuildingNames.contains(buildingName))
      visitedBuildingNames.add(buildingName);
  }

  Future updateLogs(Log log) async {
    try {
      await _logsCollectionReference.document().setData(log.toJson());
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

  Future getSuggestions() async {
    try {
      var list = await _suggestionsCollectionReference.getDocuments();
      if (list.documents.isNotEmpty) {
        return list.documents
            .map((snapshot) => Suggestion.fromJson(snapshot.data))
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addSuggestion(Suggestion suggestion) async {
    try {
      await _suggestionsCollectionReference
          .document('${suggestion.title}')
          .setData(suggestion.toJson());
      return true;
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

  Future addBuilding(Building building) async {
    try {
      await _buildingsCollectionReference
          .document('${building.name}')
          .setData(building.toJson());
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
