import 'dart:io';

import 'package:dbms/constants.dart';
import 'package:dbms/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Dio dio = Dio();
  Map userDetail = {};
  List serviceLocation = [];
  List deviceDetails = [];
  bool isLoading = true;
  bool isExpand = false;
  Future<void> getData() async {
    try {
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';
      Response response = await dio.get(
        '${baseUrl}u/home',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      // print(response.data);
      setState(() {
        userDetail = response.data["userDetails"];
        serviceLocation = response.data["serviceLocationData"];
        isLoading = false;
      });
    } catch (e) {
      print(e);
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
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return (isLoading)
        ? loader(context)
        : Scaffold(
            appBar: navbar(context),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Details",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Name: ${userDetail["firstName"]} ${userDetail["lastName"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Email: ${userDetail["email"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Billing Address: ${userDetail["address_line"]}, ${userDetail["city"]}, ${userDetail["state"]}, ${userDetail["zipcode"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text("DOB: 2001-12-21",
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 15,
                            //     )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Service Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            for (var i in serviceLocation) ...[
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${i["address_line"]}, ${i["city"]}, ${i["state"]}, ${i["zipcode"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Text(i["loc_type"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                  Row(
                                    children: [
                                      OutlinedButton(
                                          onPressed: () async {
                                            // dio.options.headers[
                                            //         'ngrok-skip-browser-warning'] =
                                            //     '69420';
                                            // Response response = await dio.delete(
                                            //   '${baseUrl}u/serviceloc/${i["locID"]}',
                                            // );
                                            // print(response.data);
                                            // setState(() {
                                            //   isExpand = true;
                                            //   deviceDetails =
                                            //       response.data["deviceData"];
                                            // });
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      "Do you want to delete"),
                                                  content: Text(i["loc_type"]),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                            context, "Yes");
                                                        try {
                                                          dio.options.headers[
                                                                  'ngrok-skip-browser-warning'] =
                                                              '69420';
                                                          await dio.delete(
                                                            '${baseUrl}u/serviceloc/${i["locID"]}',
                                                            options: Options(
                                                                headers: {
                                                                  HttpHeaders
                                                                          .contentTypeHeader:
                                                                      "application/json",
                                                                  HttpHeaders
                                                                          .authorizationHeader:
                                                                      "Bearer $jwt"
                                                                }),
                                                          );
                                                        } catch (e) {}

                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MyHomePage()),
                                                        );
                                                      },
                                                      child: Text("Yes"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, "No");
                                                      },
                                                      child: Text("No"),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text("Delete",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white)),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 202, 32, 32),
                                            foregroundColor:
                                                const Color.fromARGB(
                                                    255, 202, 32, 32),
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      OutlinedButton(
                                        onPressed: () async {
                                          dio.options.headers[
                                                  'ngrok-skip-browser-warning'] =
                                              '69420';
                                          Response response = await dio.get(
                                            '${baseUrl}u/home/${i["locID"]}',
                                            options: Options(headers: {
                                              HttpHeaders.contentTypeHeader:
                                                  "application/json",
                                              HttpHeaders.authorizationHeader:
                                                  "Bearer $jwt"
                                            }),
                                          );
                                          print(response.data);
                                          setState(() {
                                            isExpand = true;
                                            deviceDetails =
                                                response.data["deviceData"];
                                          });
                                        },
                                        child: Text("View",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.deepPurple)),
                                        style: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: isExpand,
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Apt 1R 277 Halsey St, Brooklyn, NY 11216",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 1,
                              ),
                              for (var i in deviceDetails) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.09,
                                      child: Text(i["modelNumber"],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          )),
                                    ),
                                    // OutlinedButton(
                                    //   onPressed: () {},
                                    //   child: Text("Ty",
                                    //       style: TextStyle(
                                    //           fontSize: 15, color: Colors.deepPurple)),
                                    //   style: OutlinedButton.styleFrom(
                                    //       backgroundColor: Colors.white,
                                    //       foregroundColor: Colors.white),
                                    // ),
                                    Text(i["deviceType"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                    OutlinedButton(
                                        onPressed: () async {
                                          // dio.options.headers[
                                          //         'ngrok-skip-browser-warning'] =
                                          //     '69420';
                                          // Response response = await dio.delete(
                                          //   '${baseUrl}u/devices/${i["modelID"]}',
                                          // );
                                          // print(response.data);
                                          // setState(() {
                                          //   isExpand = true;
                                          //   deviceDetails =
                                          //       response.data["deviceData"];
                                          // });

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Do you want to delete"),
                                                content: Text(i["deviceType"]),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(
                                                          context, "Yes");
                                                      try {
                                                        dio.options.headers[
                                                                'ngrok-skip-browser-warning'] =
                                                            '69420';
                                                        Response response =
                                                            await dio.delete(
                                                          '${baseUrl}u/devices/${i["deID"]}',
                                                          options:
                                                              Options(headers: {
                                                            HttpHeaders
                                                                    .contentTypeHeader:
                                                                "application/json",
                                                            HttpHeaders
                                                                    .authorizationHeader:
                                                                "Bearer $jwt"
                                                          }),
                                                        );
                                                      } catch (e) {}

                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyHomePage()),
                                                      );
                                                    },
                                                    child: Text("Yes"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, "No");
                                                    },
                                                    child: Text("No"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text("Delete",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white)),
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 202, 32, 32),
                                          foregroundColor: const Color.fromARGB(
                                              255, 202, 32, 32),
                                        )),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )

            // Container(
            //   width: width,
            //   height: height,
            //   color: Colors.deepPurple,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         "Welcome to SHEMS",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         "Smart Home Energy Management System",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
            );
  }
}
