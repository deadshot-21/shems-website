// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dbms/constants.dart';
import 'package:dbms/home/home.dart';
import 'package:dbms/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LocationService extends StatefulWidget {
  const LocationService({super.key});

  @override
  State<LocationService> createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController aptNo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController rooms = TextEditingController();
  TextEditingController occupants = TextEditingController();
  TextEditingController label = TextEditingController(text: 'Location Type');
  TextEditingController dateController = TextEditingController();
  DateTime date = DateTime(1900);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navbar(context),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
              width: MediaQuery.of(context).size.width / 3.5,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Text(
                      'Location Service',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 4 + 10,
                        height: MediaQuery.of(context).size.height / 23,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 5),
                          child: TextFormField(
                            style: TextStyle(color: Colors.deepPurple),
                            decoration: InputDecoration.collapsed(
                                hintText: "Address Line"),
                            controller: aptNo,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length > 26) {
                                return 'Less than 26 characters';
                              }
                              return null;
                            },
                          ),
                        )),
                    // Container(
                    //     width: MediaQuery.of(context).size.width / 8,
                    //     height: MediaQuery.of(context).size.height / 23,
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.white),
                    //         borderRadius: BorderRadius.circular(5),
                    //         color: Colors.white),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 16.0, vertical: 5),
                    //       child: TextFormField(
                    //         style: TextStyle(color: Colors.deepPurple),
                    //         decoration: InputDecoration.collapsed(
                    //           hintText: "Street",
                    //         ),
                    //       ),
                    //     )),
                    // ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration:
                                    InputDecoration.collapsed(hintText: "City"),
                                controller: city,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
                                    return 'No Numbers or Special Characters';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration: InputDecoration.collapsed(
                                  hintText: "State",
                                ),
                                controller: state,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
                                    return 'No Numbers or Special Characters';
                                  }
                                  return null;
                                },
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration: InputDecoration.collapsed(
                                    hintText: "ZIP Code"),
                                controller: zipCode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (value.length != 5) {
                                    return '5 Digits';
                                  }
                                  if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                    return 'No Letters or Special Characters';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                  controller: dateController,
                                  style: TextStyle(color: Colors.deepPurple),
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Date Bought",
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    date = (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100)))!;
                                    setState(() {});
                                    dateController.text = date.year.toString() +
                                        "-" +
                                        date.month.toString() +
                                        "-" +
                                        date.day.toString();
                                  }),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration: InputDecoration.collapsed(
                                    hintText: "Size (sq. ft.))"),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: size,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                    return 'No Letters or Special Characters';
                                  }
                                  if (int.parse(value) > 25000) {
                                    return 'Less than 25000 sq. ft.';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration: InputDecoration.collapsed(
                                  hintText: "No. of Rooms",
                                ),
                                controller: rooms,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                    return 'No Letters or Special Characters';
                                  }
                                  if (int.parse(value) > 10) {
                                    return 'Less than 10 Rooms';
                                  }
                                  return null;
                                },
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              child: TextFormField(
                                style: TextStyle(color: Colors.deepPurple),
                                decoration: InputDecoration.collapsed(
                                    hintText: "No. of Occupants"),
                                controller: occupants,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                    return 'No Letters or Special Characters';
                                  }
                                  if (int.parse(value) > 10) {
                                    return 'Less than 10 Occupants';
                                  }
                                  return null;
                                },
                              ),
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width / 8,
                            height: MediaQuery.of(context).size.height / 23,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5),
                              // child: TextFormField(
                              //   onTap: () {
                              //     // DropdownButton<String>(
                              //     //   // style: TextStyle(color: Colors.white),
                              //     //   isExpanded: true,
                              //     //   underline: Container(
                              //     //     height: 0,
                              //     //   ),
                              //     //   items: <String>['A', 'B', 'C', 'D']
                              //     //       .map((String value) {
                              //     //     return DropdownMenuItem<String>(
                              //     //       value: value,
                              //     //       child: Text(value),
                              //     //     );
                              //     //   }).toList(),
                              //     //   onChanged: (_) {},
                              //     // );
                              //   },
                              //   style: TextStyle(color: Colors.deepPurple),
                              //   decoration: InputDecoration.collapsed(
                              //     hintText: "Location Type",
                              //   ),
                              //   controller: label,
                              //   autovalidateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   validator: (value) {
                              //     if (value!.isEmpty) {
                              //       return 'Please enter some text';
                              //     }
                              //     if (!RegExp(r'^[a-z]+$').hasMatch(value)) {
                              //       return 'No Numbers or Special Characters';
                              //     }
                              //     if (int.parse(value) < 11) {
                              //       return 'Less than 10 Rooms';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              child: DropdownButton<String>(
                                // style: TextStyle(color: Colors.white),
                                hint: Text(label.text),
                                isExpanded: true,
                                underline: Container(
                                  height: 0,
                                ),
                                items: <String>[
                                  'AirBnB',
                                  'Residential',
                                  'Vacation'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    label.text = value!;
                                  });
                                },
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            label.text != 'Location Type') {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('Processing Data')));
                          Dio dio = new Dio();
                          var response = await dio.post(
                            baseUrl + 'u/serviceloc',
                            data: {
                              "address_line": aptNo.text,
                              "street": street.text,
                              "city": city.text,
                              "state": state.text,
                              "zipcode": zipCode.text,
                              "date_tookover": date.toIso8601String(),
                              "area": size.text,
                              "num_bed": rooms.text,
                              "num_occupants": occupants.text,
                              "loc_type": label.text,
                            },
                            options: Options(headers: {
                              HttpHeaders.contentTypeHeader: "application/json",
                              HttpHeaders.authorizationHeader: "Bearer $jwt"
                            }),
                          );
                          // print(response);
                          if (response.data['status']) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Location Added')));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                            );
                          } else {
                            print(response.data);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Error')));
                          }
                        }
                      },
                      child: Text(
                        "Add Service Location",
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                    )
                  ]),
                ),
              )),
        ),
      ),
    );
  }
}
