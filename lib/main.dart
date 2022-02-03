import 'package:flutter/material.dart';
import 'package:my_app/api.dart';

import 'Screens/homepage.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home:HomePage(),
    );
  }
}

