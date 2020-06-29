import '../frontend/personalData.dart';
import 'package:flutter/material.dart';
import '../frontend/checkInMain.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PersonalData _personalData = new PersonalData();
  String _radioGroupValue = 'Student';

  @override
  void initState() {
    super.initState();
    setState(() {
      _radioGroupValue = 'Student';
      _personalData.getPersonalData();
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        //alignment:Alignment.,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            _radioWithLabelWidget('Student'),
                            _radioWithLabelWidget('Staff'),
                            _radioWithLabelWidget('Guest'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _textFieldFormWidget("Name", false, _personalData.name),
                  _textFieldFormWidget("Phone", false, _personalData.phone),
                  _textFieldFormWidget("Address", false, _personalData.address),
                  _textFieldFormWidget("Reason", true, _personalData.reason),
                  Row(
                    children: <Widget>[
                      const Spacer(),
                      OutlineButton(
                        highlightedBorderColor: Colors.black,
                        onPressed: _submit,
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //)
        ),
      ),
    );
  }

  Widget _textFieldFormWidget(String fieldText, bool last, Future<String> value){

    return FutureBuilder<String>(
        future: value,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: value == null? "" : snapshot.data,
                      keyboardType: fieldText == "Phone"
                          ? TextInputType.phone
                          : TextInputType.text,
                      onFieldSubmitted: (_) => last == false
                          ? FocusScope.of(context).nextFocus()
                          : FocusScope.of(context).unfocus(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: '$fieldText',
                      ),
                      validator: (value) => _validateTextRequired(value, fieldText),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                );
              }
          }
        }
    );
  }

  Widget _radioWithLabelWidget(String val){
    return Row(
      children: <Widget>[
        Radio(
          value: val,
          groupValue: _radioGroupValue,
          onChanged: (radioValue) {
            setState(() { _radioGroupValue = radioValue;});
            },
        ),
        Text(val),
      ],
    );
  }

  String _validateTextRequired(String value, String field)  {

     if(value.isEmpty) {
       return '$field is Required';
     } else {
       _saveValueToSharedPreference(field, value);
       return null;
    }
  }

  void _submit() async {

    final prefs = await SharedPreferences.getInstance();

    if(_formKey.currentState.validate()){

      _saveValueToSharedPreference("isRegistered", "Yes");
      _saveValueToSharedPreference("InsideBldg","No Where");
      _saveValueToSharedPreference("Status",_radioGroupValue);


      Navigator.pushReplacement(context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => CheckInHome(),
          )
      );
    }
    else
      prefs.setString("isRegistered", null);
    print('Form submitted');
  }

  void _saveValueToSharedPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print("$key---${prefs.getString(key)}");
  }
}

