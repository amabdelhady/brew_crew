import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/consts.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      // ignore: missing_return
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
        if(snapshot.hasData){
          return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Settings.',
                    style: TextStyle(fontSize:18.0),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please Enter Your Name': null,
                    onChanged: (val) => setState(()=> _currentName = val),
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar){
                      return DropdownMenuItem<String>(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(()=> _currentSugars  = val),
                  ),
                  SizedBox(height: 20.0,),

                  //slider
                  Slider(
                    value: (_currentStrength ?? 100).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(()=> _currentStrength = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async{
                      print(_currentName);
                      print(_currentSugars);
                      print(_currentStrength);
                    },
                  )
                ],
              )
          );
        }else{
          return Loading();
        }
      }
    );
  }
}

