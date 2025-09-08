import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screens/signup_screen.dart';
import 'package:personal_finance_tracker/services/auth_services.dart';
import 'package:personal_finance_tracker/utils/app_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var authServices = AuthServices();
  var isLoading = false;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> submitForm() async {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        var data = {
          "email": emailController.text,
          "password": passwordController.text,
        };
        await authServices.loginUser(data, context);
        setState(() {
          isLoading = false;
        });
      }
    }

    var validator = AppValidator();

    return Scaffold(
      backgroundColor: Color(0XFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 60.0),
              SizedBox(
                width: 250.0,
                child: Text(
                  "Login Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: buildInputDecoration('Email', Icons.email),
                validator: validator.validateEmail,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                decoration: buildInputDecoration('Password', Icons.lock),
                validator: validator.validatePassword,
              ),
              SizedBox(height: 40.0),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    isLoading ? null : submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child:
                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : Text("Login"),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.blue,
                  ),
                  child: Text("Create New Account"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration(String labelText, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Color(0XAA494A59),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0X35949494)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(10.0),
      ),
      labelStyle: TextStyle(color: Color(0XFF949494)),
      labelText: labelText,
      suffixIcon: Icon(suffixIcon, color: Color(0XFF949494)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
