import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayInformationPage extends StatefulWidget{
  DisplayInformationPage({Key key}):super(key: key);

  @override
  _DisplayInformationState createState() => _DisplayInformationState();

}

class _DisplayInformationState extends State<DisplayInformationPage> {
  PersonalData personalData = PersonalData();

  @override
  void initState() {
    super.initState();
    setState(() {
      personalData.getPersonalData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return personalData.isRegistered != null
        ?
    Center(
        child: Column(
          children: <Widget>[
            _displayWidget(personalData.name, Icon(Icons.person_outline, size: 35,)),
            _displayWidget(personalData.phone, Icon(Icons.phone, size: 35,)),
            _displayWidget(personalData.status, Icon(Icons.grade, size: 35,)),
            _displayWidget(personalData.address, Icon(Icons.home, size: 35,)),
            _displayWidget(personalData.reason, Icon(Icons.help, size: 35,)),
            _displayWidget(personalData.insideBldg, Icon(Icons.place, size: 35,)),
          ],
        )
    )
        :Center(child: Text("Not here damn it"));
  }

  Widget _displayWidget(Future<String> value, Icon icon){
    return Center(
      child: FutureBuilder<String>(
          future: value,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Card(
                    color: Colors.lightBlue.shade50,
                    child: Row(
                      children: <Widget>[
                        icon,
                        Padding(
                          padding: EdgeInsets.only(top: 55, left: 20),
                        ),
                        Text("${snapshot.data}",
                        style: TextStyle(
                          fontSize: 30
                        ),)
                      ],
                    ),
                  );
                }
            }
          }
      )
    );
  }
}

class PersonalData {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> status;
  Future<String> name;
  Future<String> phone;
  Future<String> address;
  Future<String> reason;
  Future<String> isRegistered;
  Future<String> insideBldg;

  //SharedPreferences prefs;

  PersonalData({
    this.status , this.name, this.phone,
    this.address, this.reason, this.isRegistered,
  });

  Future<String> getFromSharedPref(String key){
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString(key);
    });
  }

  getPersonalData() {

    isRegistered = getFromSharedPref("isRegistered");
    status = getFromSharedPref("Status");
    name = getFromSharedPref("Name");
    phone = getFromSharedPref("Phone");
    address = getFromSharedPref("Address");
    reason = getFromSharedPref("Reason");
    insideBldg = getFromSharedPref("InsideBldg");

  }

  Future<Map<String, dynamic>> toMap() async {
     // call getPersonalData before this

    String date = new DateTime.now().toString().substring(0,10);
    String key = date + await phone + await insideBldg ;

     return <String, dynamic> {
       "status": await status,
       "name": await name,
       "phone": await phone,
       "address": await address,
       "reason": await reason,
       "insideBldg": await insideBldg,
       "date": date,
       "key" : key,
     };
  }

  PersonalData.fromMap(Map snapshot):
        status  = snapshot['status'] ?? '',
        name = snapshot['name'] ?? '',
        phone = snapshot['phone'] ?? '',
        address = snapshot['address'] ?? '',
        reason = snapshot['reason'] ?? '',
        insideBldg = snapshot['insideBldg'] ?? '';

}