import 'package:flutter/material.dart';

import 'package:ecomapp/themedata/Theme.dart' as theme;
class Contact extends StatelessWidget{

@override
Widget build(BuildContext context)
{
  return new MaterialApp(
    
    home: new Scaffold(
      backgroundColor: theme.Colors.productPageBackground,
    appBar: new AppBar(
      backgroundColor: theme.Colors.appBarTitle,
      title: new Text("Contact Us"),
    )
  ));
}

}