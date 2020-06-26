import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'personalData.dart';
//import 'package:flutter_firebase_auth/user.dart';

class FireBaseHelper{
  DatabaseReference _counterRef;
  DatabaseReference _visitorsRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FireBaseHelper _instance = new FireBaseHelper.internal();

  FireBaseHelper.internal();

  factory FireBaseHelper() {
    return _instance;
  }

  void initFDB() {
    // Demonstrates configuring to the database using a file
    // _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _visitorsRef = database.reference().child('visitors');
    /*database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });*/

    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    /*  _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });*/
  }

  addToFDB(Map map, String dbChild) async {

    _visitorsRef = FirebaseDatabase.instance.reference().child(dbChild);

    await _visitorsRef
        .orderByChild("key")
        .startAt(map["key"]).endAt(map["key"])
        .once()
        .then((DataSnapshot snapshot){
      if(snapshot.value == null){
        _visitorsRef.push().set(map).then((_) {
          print('Transaction  committed.');
        });
      } else {
        Map<dynamic, dynamic> value = snapshot.value;
        value.forEach((k, v){print(v["name"]);});
      }
    });


    /*final TransactionResult transactionResult =
    await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });*/

    /* if (transactionResult.committed) {
      _userRef.push().set(data.toMap()).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }*/
  }

}