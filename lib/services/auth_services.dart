import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screens/dashboard_screen.dart';

class AuthServices {
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Signup Failed! try again later",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  loginUser(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Email or Password is incorrect",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
