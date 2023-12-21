// ignore_for_file: prefer_const_constructors, camel_case_types, avoid_print

import 'dart:io';
import 'dart:math';

import 'package:dbms/constants.dart';
import 'package:dbms/home/home.dart';
import 'package:dbms/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WowPage extends StatefulWidget {
  const WowPage({super.key});

  @override
  State<WowPage> createState() => _WowPage();
}

class _WowPage extends State<WowPage> {
  bool isLoading = true;
  bool refresh = false;
  List<String> deviceData = [];
  List<String> serviceData = [];
  String service = "Choose Service Location";
  String device = "Choose Device";
  Map responseBackup = {};
  String name = "";
  String message = "";

  List<energyData> data = <energyData>[
    // energyData('Jan', 10, 10),
    // energyData('Feb', 15, 15),
    // energyData('Mar', 20, 20),
    // energyData('Apr', 25, 25),
    // energyData(25, 'May'),
    // energyData(30, 'Jun'),
    // energyData(35, 'Jul'),
    // energyData(40, 'Aug'),
    // energyData(35, 'Sep'),
    // energyData(30, 'Oct'),
    // energyData(25, 'Nov'),
    // energyData(20, 'Dec'),
  ];

  List<applicaneData> pieData = [
    // applicaneData("TV", 35),
    // applicaneData("AC", 28),
    // applicaneData("Fridge", 34),
    // applicaneData("Washing Machine", 32),
    // applicaneData("Microwave", 40)
  ];

  Future<void> getChartData() async {
    setState(() {
      refresh = true;
    });
    try {
      Dio dio = Dio();
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';
      var response = await dio.post(
        '${baseUrl}u/wowpage',
        data: {
          "locID": responseBackup["serviceLocationData"]
              [service.indexOf(service)]["locID"],
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      print(response.data);
      if (response.data["status"]) {
        setState(() {
          data = [];
          data.add(energyData(getString(response.data["data"][0]["m2"]),
              response.data["data"][0]["e2"], 96));
          data.add(energyData(getString(response.data["data"][0]["m1"]),
              response.data["data"][0]["e1"], 134));
          name = response.data["data"][0]["device_type"];
          message = response.data["message"];
        });
        print("DEVICE DATA");
        print(data);
        // setState(() {
        //   isLoading = false;
        // });
      }
      var response1 = await dio.post(
        '${baseUrl}u/zipcodemetrics',
        data: {
          "locID": responseBackup["serviceLocationData"]
              [service.indexOf(service)]["locID"],
        },
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      if (response1.data["status"]) {
        setState(() {
          pieData = [];
          pieData.add(applicaneData("Your Consumption",
              response1.data["data"][0]["Your_energy_consumption"]));
          pieData.add(applicaneData(
              "Total consumption in your Area",
              response1.data["data"][0]
                  ["Total_energy_consumption_in_your_Area"]));
        });
      }
      print(response1.data);
      // }
      setState(() {
        refresh = false;
      });
    } catch (e) {
      print(e);
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  Future<void> getData() async {
    try {
      Dio dio = Dio();
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';
      var response = await dio.get(
        '${baseUrl}u/serviceloc',
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
        // for (var x in response.data["devicedata"]) {
        //   deviceData.add("${x["deviceType"]} - ${x["modelNumber"]}");
        // }
      });
      // print("DEVICE DATA");
      // print(deviceData);
      setState(() {
        isLoading = false;
      });
      // }
    } catch (e) {
      print(e);
      // setState(() {
      //   isLoading = false;
      // });
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
    return (isLoading || refresh)
        ? loader(context)
        : Scaffold(
            appBar: navbar(context),
            body: Column(
              children: [
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
                          getChartData();
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 60,
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(),
                              // primaryYAxis:
                              // NumericAxis(minimum: 0, maximum: 40, interval: 10),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: [
                                ColumnSeries<energyData, String>(
                                    dataSource: data,
                                    xValueMapper: (energyData data, _) =>
                                        data.month,
                                    yValueMapper: (energyData data, _) =>
                                        data.unit,
                                    // name: 'Gold',
                                    color: Color.fromRGBO(8, 87, 153, 1)),
                                ColumnSeries<energyData, String>(
                                    dataSource: data,
                                    xValueMapper: (energyData data, _) =>
                                        data.month,
                                    yValueMapper: (energyData data, _) =>
                                        data.price,
                                    // name: 'Gold',
                                    color: Color.fromRGBO(126, 7, 7, 1)),
                              ]),
                        ),
                        Text(
                          name + ' consumed more units than last month',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Text(
                          message,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(
                        // height: MediaQuery.of(context).size.width / 7,
                        width: MediaQuery.of(context).size.width / 2 - 60,
                        child: SfCircularChart(
                            // title: ChartTitle(text: selectedChartType),
                            legend: Legend(isVisible: true),
                            series: <DoughnutSeries<applicaneData, String>>[
                              DoughnutSeries<applicaneData, String>(
                                  radius: "200",
                                  enableTooltip: true,
                                  explode: true,
                                  explodeIndex: 0,
                                  dataSource: pieData,
                                  xValueMapper: (applicaneData data, _) =>
                                      data.xData,
                                  yValueMapper: (applicaneData data, _) =>
                                      data.yData,
                                  //  dataLabelMapper: (_PieData data, _) => data.text,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                            ])),
                  ],
                ),
              ],
            ));
  }
}

class energyData {
  energyData(this.month, this.unit, this.price);
  final num unit;
  final String month;
  final num price;
}

// class priceData {
//   priceData(this.month, this.price);
//   final int price;
//   final String month;
// }
class applicaneData {
  applicaneData(this.xData, this.yData);
  final String xData;
  final num yData;
}

String getString(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "July";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    default:
      return "Dec";
  }
}
