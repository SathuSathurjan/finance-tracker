import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDCqfwfFxu9a_7z4b7T0lrq-7o2cRjl-HI",
        authDomain: "finance-tracker-b8fc3.firebaseapp.com",
        projectId: "finance-tracker-b8fc3",
        storageBucket: "finance-tracker-b8fc3.firebasestorage.app",
        messagingSenderId: "903686476438",
        appId: "1:903686476438:web:f8a3f34e1b5e521486e8b7",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: AuthGate(),
    );
  }
}
