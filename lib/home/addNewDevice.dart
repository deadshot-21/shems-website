// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dbms/constants.dart';
import 'package:dbms/home/home.dart';
import 'package:dbms/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewDevice extends StatefulWidget {
  const NewDevice({super.key});

  @override
  State<NewDevice> createState() => _NewDeviceState();
}

class _NewDeviceState extends State<NewDevice> {
  bool isLoading = true;
  List<String> deviceData = [];
  List<String> serviceData = [];
  String service = "Choose Service Location";
  String device = "Choose Device";
  Map responseBackup = {};

  Future<void> getData() async {
    try {
      Dio dio = Dio();
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';
      var response = await dio.get(
        '${baseUrl}u/devices',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      print(response.data);
      // if (response.data["status"]) {
      responseBackup = response.data;
      setState(() {
        for (var x in response.data["serviceLocationData"]) {
          serviceData.add(
              "${x["address_line"]}, ${x["city"]}, ${x["state"]}, ${x["zipcode"]}");
        }
        for (var x in response.data["devicedata"]) {
          deviceData.add("${x["deviceType"]} - ${x["modelNumber"]}");
        }
      });
      print("DEVICE DATA");
      print(deviceData);
      setState(() {
        isLoading = false;
      });
      // }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading)
        ? loader(context)
        : Scaffold(
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
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Add New Device",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Select Service Location:",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        alignment: Alignment.topLeft,
                        // height: 30,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            // style: TextStyle(color: Colors.white),
                            hint: Text(service),
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                            ),
                            items: serviceData.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                service = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Device Name:",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w100,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        alignment: Alignment.topLeft,
                        // height: 30,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            // style: TextStyle(color: Colors.white),
                            hint: Text(device),
                            isExpanded: true,
                            underline: Container(
                              height: 0,
                            ),
                            items: deviceData.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                device = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            Dio dio = Dio();
                            dio.options.headers['ngrok-skip-browser-warning'] =
                                '69420';
                            var response = await dio.post(
                              '${baseUrl}u/devices',
                              data: {
                                "modelID": responseBackup["devicedata"][
                                        deviceData.indexWhere(
                                            (element) => element == device)]
                                    ["modelID"],
                                "locID": responseBackup["serviceLocationData"][
                                        serviceData.indexWhere(
                                            (element) => element == service)]
                                    ["locID"]
                              },
                              options: Options(headers: {
                                HttpHeaders.contentTypeHeader:
                                    "application/json",
                                HttpHeaders.authorizationHeader: "Bearer $jwt"
                              }),
                            );
                            print(response.data);
                            if (response.data["status"]) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Device Added Successfully"),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Device Already Exists"),
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text("Add Device"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
