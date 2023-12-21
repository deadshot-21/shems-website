// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dbms/authentication/login.dart';
import 'package:dbms/constants.dart';
import 'package:dbms/home/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurpleAccent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              // height: MediaQuery.of(context).size.height - 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Divider(
                                          color: Colors.deepPurple,
                                          thickness: 1,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "First Name:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                              hintText: "John",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Last Name:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          controller: _lastNameController,
                                          decoration: InputDecoration(
                                              hintText: "Doe",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Email:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (!RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value)) {
                                              return "Please enter a valid email";
                                            }
                                            return null;
                                          },
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              hintText: "ja987@nyu.edu",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Password:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (value.length < 6) {
                                              return 'Password greater than 6 characters';
                                            }
                                            return null;
                                          },
                                          controller: _passwordController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Jay@123",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.deepPurple),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.deepPurple),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Address First Line:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (value.length > 26) {
                                              return 'Less than 26 characters';
                                            }
                                            return null;
                                          },
                                          controller: _addressController,
                                          decoration: InputDecoration(
                                              hintText: "277 Halsey Street",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "City:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (!RegExp(r'^[a-z]+$')
                                                .hasMatch(value)) {
                                              return 'No Numbers or Special Characters';
                                            }
                                            return null;
                                          },
                                          controller: _cityController,
                                          decoration: InputDecoration(
                                              hintText: "New York",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "State:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (!RegExp(r'^[a-z]+$')
                                                .hasMatch(value)) {
                                              return 'No Numbers or Special Characters';
                                            }
                                            return null;
                                          },
                                          controller: _stateController,
                                          decoration: InputDecoration(
                                              hintText: "New York",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "ZIP Code:",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: Colors.deepPurple),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            if (value.length != 5) {
                                              return '5 Digits';
                                            }
                                            if (!RegExp(r'^[0-9]*$')
                                                .hasMatch(value)) {
                                              return 'No Letters or Special Characters';
                                            }
                                            return null;
                                          },
                                          controller: _pinCodeController,
                                          decoration: InputDecoration(
                                              hintText: "11216",
                                              hintStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w100,
                                                  color: Colors.deepPurple),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.deepPurple),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              )),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.deepPurple),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // ScaffoldMessenger.of(context).showSnackBar(
                                                //     const SnackBar(content: Text('Processing Data')));
                                                // print(_emailController.text);
                                                // print(_passwordController.text);
                                                // print(_firstNameController.text);
                                                // print(_lastNameController.text);
                                                // print(_addressController.text);
                                                // print(_cityController.text);
                                                // print(_stateController.text);
                                                // print(_pinCodeController.text);
                                                // print("hello");
                                                try {
                                                  Dio dio = Dio();
                                                  dio.options.headers[
                                                          'ngrok-skip-browser-warning'] =
                                                      '69420';
                                                  var response = await dio.post(
                                                      '${baseUrl}u/register',
                                                      data: {
                                                        "email":
                                                            _emailController
                                                                .text,
                                                        "password":
                                                            _passwordController
                                                                .text,
                                                        "firstName":
                                                            _firstNameController
                                                                .text,
                                                        "lastName":
                                                            _lastNameController
                                                                .text,
                                                        "address_line":
                                                            _addressController
                                                                .text,
                                                        "city": _cityController
                                                            .text,
                                                        "state":
                                                            _stateController
                                                                .text,
                                                        "zipcode":
                                                            _pinCodeController
                                                                .text
                                                      });
                                                  print(response.data);
                                                  if (response.data["status"]) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Logged in successfully")));
                                                    // var storage =
                                                    //     FlutterSecureStorage();
                                                    // await storage.write(
                                                    //     key: "token",
                                                    //     value: response
                                                    //         .data["token"]);
                                                    jwt = response.data["data"]
                                                        ["token"];
                                                    await Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyHomePage()));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                "Invalid credentials")));
                                                  }
                                                } catch (e) {
                                                  print(e);
                                                }
                                              }
                                            },
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () async {
                                          await Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()));
                                        },
                                        child: Text(
                                          "Already Registered?",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.deepPurple,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                      SizedBox(height: 20)
                                    ]),
                              ))
                        ]),
                  ))),
          Image.asset(
            "assets/images/login.png",
            // width: MediaQuery.of(context).size.width / 3.5,
            // height: MediaQuery.of(context).size.height / 2
          ),
        ],
      ),
    );
  }
}
