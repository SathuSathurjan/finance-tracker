import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void submitForm() {
      if (_formKey.currentState!.validate()) {}
    }

    String? _validateEmail(value) {
      if (value!.isEmpty) {
        return 'Please Enter Your Email';
      }
      RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!regex.hasMatch(value)) {
        return 'Enter a valid email address';
      }
      return null;
    }

    String? _validatePhoneNumber(value) {
      if (value == null || value.isEmpty) {
        return "Please Enter Your Phone number";
      }
      if (!RegExp(r'^\d+$').hasMatch(value)) {
        return "Phone number must contain only digits";
      }
      if (!value.startsWith('7')) {
        return "phone number must start with 7";
      }
      if (value.length != 9) {
        return "Invalid Phone number";
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Your User Name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: _validateEmail,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: _validatePhoneNumber,
                maxLength: 9,
                keyboardType: TextInputType.phone, //for number dialpad
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10.0,
                  ),
                  labelText: 'Phone Number',
                  prefixText: '+94',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Sign Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
