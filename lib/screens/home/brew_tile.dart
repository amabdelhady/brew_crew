import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:flutter/widgets.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  const BrewTile({this.brew});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text("Takes Coffee with ${brew.sugars} sugar(s)."),
        ),
      ),
    );
  }
}
