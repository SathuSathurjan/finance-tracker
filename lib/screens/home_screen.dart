import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutClicked = false;

  logOut() async {
    setState(() {
      isLogoutClicked = true;
    });
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
    setState(() {
      isLogoutClicked = false;
    });
  }

  void addTransaction() {
    showDialog(
      context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        String amount = '';
        String category = '';
        String description = '';
        String transactionType = 'income';
        DateTime? selectedDate;

        return AlertDialog(
          title: Text(
            'Add Transaction',
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          content: Form(
            key: _formKey,
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) => amount = value,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter value'
                                    : null,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) => category = value,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter value'
                                    : null,
                      ),
                      SizedBox(height: 10.0),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type'),
                              Row(
                                children: [
                                  Radio<String>(
                                    value: 'income',
                                    groupValue: transactionType,
                                    onChanged: (value) {
                                      setState(() {
                                        transactionType = value!;
                                      });
                                    },
                                  ),
                                  Text('Income'),
                                  Radio<String>(
                                    value: 'expense',
                                    groupValue: transactionType,
                                    onChanged: (value) {
                                      setState(() {
                                        transactionType = value!;
                                      });
                                    },
                                  ),
                                  Text('Expense'),
                                ],
                              ),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                      Text('Date'),
                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            selectedDate == null
                                ? 'Select Date'
                                : '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) => description = value,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter value'
                                    : null,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: addTransaction,
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.blue.shade900, size: 30.0),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text("hello", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon:
                isLogoutClicked
                    ? CircularProgressIndicator()
                    : Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blue.shade900,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Welcome back!",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 15.0),
                  Text(
                    "total balance",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    "132,194.00",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Income",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "42,194.00",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Expense",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              "15,455.00",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Text("Telephone bill"),
                      Text("-1800.00", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Balance"),
                          Spacer(),
                          Text("900.00", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Text("8 Sept 3:00 PM",style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
