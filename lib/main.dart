import 'package:checklist_app/services/Database.dart';
import 'package:checklist_app/view/home/AppStateProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Database();
  runApp(AppStateProvider());
}
