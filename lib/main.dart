import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salary_app/firebase_options.dart';
import 'package:salary_app/src/app.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}
