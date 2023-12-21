// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:dbms/authentication/register.dart';
import 'package:dbms/constants.dart';
import 'package:dbms/home/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.height / 2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        "Login",
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
                                          controller: emailController,
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
                                          controller: passwordController,
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
                                              if (emailController
                                                      .text.isEmpty ||
                                                  passwordController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Please fill all the fields")));
                                              } else {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  try {
                                                    Dio dio = Dio();
                                                    dio.options.headers[
                                                            'ngrok-skip-browser-warning'] =
                                                        '69420';
                                                    var response = await dio
                                                        .post(
                                                            '${baseUrl}u/login',
                                                            data: {
                                                          "email":
                                                              emailController
                                                                  .text,
                                                          "password":
                                                              passwordController
                                                                  .text,
                                                        });
                                                    print(response.data);
                                                    if (response
                                                        .data["status"]) {
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
                                                      jwt = response
                                                          .data["data"]["token"];
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
                                                // await login(
                                                //     emailController.text,
                                                //     passwordController.text,
                                                //     context);
                                              }
                                              // },
                                            },
                                            child: Text(
                                              "Login",
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
                                                      Register()));
                                        },
                                        child: Text(
                                          "Not Registered?",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w100,
                                              color: Colors.deepPurple,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ]),
                              ),
                            ))
                      ]))),
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
