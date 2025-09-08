import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screens/login_screen.dart';
import 'package:personal_finance_tracker/services/auth_services.dart';
import 'package:personal_finance_tracker/utils/app_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  var authServices = AuthServices();

  var isLoading = false;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var data = {
        "username": usernameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "password": passwordController.text,
      };
      await authServices.createUser(data, context);     
      setState(() {
        isLoading = false;
      });
    }
  }

  var validator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.0),
                SizedBox(
                  width: 250.0,
                  child: Text(
                    "Create a new Account",
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
                  controller: usernameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(color: Colors.white),
                  decoration: buildInputDecoration('User Name', Icons.person),
                  validator: validator.validateUserName,
                ),
                SizedBox(height: 16.0),
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
                  controller: phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLength: 9,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0X35949494)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Color(0XAA494A59),
                    filled: true,
                    labelStyle: TextStyle(color: Color(0XFF949494)),
                    suffixIcon: Icon(Icons.phone, color: Color(0XFF949494)),
                    counterText: "",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 10.0,
                    ),
                    labelText: 'Phone Number',
                    prefixText: '+94 ',
                    prefixStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: validator.validatePhoneNumber,
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
                            : Text("Create"),
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
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.blue,
                    ),
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
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
