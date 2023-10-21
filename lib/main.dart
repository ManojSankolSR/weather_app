import 'package:flutter/material.dart';
import 'package:weather_app/HomeScreen.dart';
import 'package:weather_app/loadingscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: loadingScreen(),
  ));
}
