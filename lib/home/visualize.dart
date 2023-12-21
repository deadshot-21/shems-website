// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:dbms/constants.dart';
import 'package:dbms/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Visualize extends StatefulWidget {
  const Visualize({super.key});

  @override
  State<Visualize> createState() => _VisualizeState();
}

class _VisualizeState extends State<Visualize> {
  List<energyData> chartData = [
    // energyData(35, DateTime(2010, 1, 1)),
    // energyData(28, DateTime(2011, 1, 1)),
    // energyData(34, DateTime(2012, 1, 1)),
    // energyData(32, DateTime(2013, 1, 1)),
    // energyData(40, DateTime(2014, 1, 1))
  ];
  List<applicaneData> pieData = [
    // applicaneData("TV", 35),
    // applicaneData("AC", 28),
    // applicaneData("Fridge", 34),
    // applicaneData("Washing Machine", 32),
    // applicaneData("Microwave", 40)
  ];

  List<List<energyData>> chartDataAll = [];
  Map responseBackup = {};
  List<String> serviceData = ["All"];
  String selectedService = "";
  bool isLoading = true;
  List<String> chartType = [
    "Price for Service Location",
    "Energy Consumption for Service location",
    "Price for Appliances (Service Location)",
    "Energy Consumption for Appliances (Service Location)"
  ];
  List<String> chartTypeAll = [
    "Price for Service Location",
    "Energy Consumption for Service location",
    "Price for Appliances (Service Location)",
    "Energy Consumption for Appliances (Service Location)"
  ];
  List<String> chartTypeNormal = [
    "Price for Service Location",
    "Energy Consumption for Service location",
    "Price for Appliances (Service Location)",
    "Energy Consumption for Appliances (Service Location)"
  ];
  String selectedChartType = "Price for Service Location";
  int setChartTypeIndex = 0;
  List<String> year = ['2021', '2022'];
  List<String> month = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  List<String> view = ['Yearly', 'Monthly', 'Daily'];
  List<String> viewLine = ['Yearly', 'Monthly', 'Daily'];
  List<String> viewPie = ['Yearly', 'Monthly'];
  List<String> viewAll = ['Monthly'];
  String selectedYear = "2022";
  String selectedMonth = "1";
  String selectedView = "Monthly";
  bool isFirst = true;
  bool isEmpty = false;

  Future<void> getData() async {
    try {
      Dio dio = Dio();
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';
      var response = await dio.get(
        '${baseUrl}u/dashboard',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      print(response.data);
      if (response.data["status"]) {
        if (response.data["data"].length == 0) {
          setState(() {
            isEmpty = true;
            isLoading = false;
          });
          return;
        }
        responseBackup = response.data;
        setState(() {
          for (var x in response.data["data"]) {
            serviceData.add(
                "${x["address_line"]}, ${x["city"]}, ${x["state"]}, ${x["zipcode"]}");
          }
          selectedService = serviceData[1];
          if (isFirst) {
            setChartData();
            isFirst = false;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No Devices Found"),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void setData(response) {
    setState(() {
      if (selectedService != "All" &&
          (setChartTypeIndex == 2 || setChartTypeIndex == 3)) {
        pieData = [];
        for (var x in response["deviceData"]) {
          pieData.add(applicaneData(x["x_axis"], x["y_axis"]));
        }
      } else if (selectedService == "All") {
        print("here");
        // chartData = [];
        chartDataAll = [];
        var data = {};
        for (var x in response["deviceData"]) {
          if (data[x["Location_ID"]] == null) {
            data[x["Location_ID"]] = <energyData>[];
          }
          data[x["Location_ID"]].add(energyData(
              x["y_axis"],
              DateTime(x["year"] ?? int.parse(selectedYear),
                  x["month"] ?? int.parse(selectedMonth), x["day"] ?? 1)));
          // chartData.add(energyData(x["y_axis"],
          //     DateTime(x["year"] ?? 2021, x["month"] ?? 1, x["day"] ?? 1)));
        }
        for (var x in data.values) {
          chartDataAll.add(x);
        }
      } else {
        chartData = [];
        for (var x in response["deviceData"]) {
          chartData.add(energyData(
              x["y_axis"],
              DateTime(x["year"] ?? int.parse(selectedYear),
                  x["month"] ?? int.parse(selectedMonth), x["day"] ?? 1)));
        }
      }
    });
  }

  Future<void> setChartData() async {
    try {
      Dio dio = Dio();
      dio.options.headers['ngrok-skip-browser-warning'] = '69420';

      var responseLine = await dio.get(
        '${baseUrl}u/mu/0/${responseBackup["data"][serviceData.indexWhere((element) => element == selectedService)]["locID"]}/$selectedYear',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      print("object");
      print(responseLine.data);
      chartData = [];
      for (var x in responseLine.data["deviceData"]) {
        chartData.add(energyData(
            x["y_axis"],
            DateTime(x["year"] ?? int.parse(selectedYear),
                x["month"] ?? int.parse(selectedMonth), x["day"] ?? 1)));
      }
      var responsePie = await dio.get(
        '${baseUrl}u/mu/2/${responseBackup["data"][serviceData.indexWhere((element) => element == selectedService)]["locID"]}/$selectedYear',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $jwt"
        }),
      );
      pieData = [];
      for (var x in responsePie.data["deviceData"]) {
        pieData.add(applicaneData(x["x_axis"], x["y_axis"]));
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isEmpty = true;
      });

      print(e);
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
        : (isEmpty)
            ? Scaffold(appBar: navbar(context), body: Text("NO DATA!"))
            : Scaffold(
                appBar: navbar(context),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    (selectedService == "All")
                        ? Container(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: SfCartesianChart(
                                primaryXAxis: DateTimeAxis(),
                                series: <CartesianSeries>[
                                  for (var x in chartDataAll)
                                    StackedLineSeries<energyData, DateTime>(
                                        dataSource: x,
                                        xValueMapper: (energyData data, _) =>
                                            data.month,
                                        yValueMapper: (energyData data, _) =>
                                            data.unit),
                                  // StackedLineSeries<energyData, DateTime>(
                                  //     dataSource: chartData,
                                  //     xValueMapper: (energyData data, _) =>
                                  //         data.month,
                                  //     yValueMapper: (energyData data, _) =>
                                  //         data.unit),
                                  // StackedLineSeries<ChartData, String>(
                                  //     dataSource: chartData,
                                  //     xValueMapper: (ChartData data, _) => data.x,
                                  //     yValueMapper: (ChartData data, _) => data.y2
                                  // ),
                                  //  StackedLineSeries<ChartData, String>(
                                  //     dataSource: chartData,
                                  //     xValueMapper: (ChartData data, _) => data.x,
                                  //     yValueMapper: (ChartData data, _) => data.y3
                                  // ),
                                  // StackedLineSeries<ChartData, String>(
                                  //     dataSource: chartData,
                                  //     xValueMapper: (ChartData data, _) => data.x,
                                  //     yValueMapper: (ChartData data, _) => data.y4
                                  // )
                                ]))
                        : (setChartTypeIndex == 2 || setChartTypeIndex == 3)
                            ? Container(
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: SfCircularChart(
                                    title: ChartTitle(text: selectedChartType),
                                    legend: Legend(isVisible: true),
                                    series: <PieSeries<applicaneData, String>>[
                                      PieSeries<applicaneData, String>(
                                          radius: "200",
                                          enableTooltip: true,
                                          explode: true,
                                          explodeIndex: 0,
                                          dataSource: pieData,
                                          xValueMapper:
                                              (applicaneData data, _) =>
                                                  data.xData,
                                          yValueMapper:
                                              (applicaneData data, _) =>
                                                  data.yData,
                                          //  dataLabelMapper: (_PieData data, _) => data.text,
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true)),
                                    ]))
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.4,
                                width: MediaQuery.of(context).size.width / 1.7,
                                child: SfCartesianChart(
                                    enableAxisAnimation: true,
                                    tooltipBehavior: TooltipBehavior(
                                        enable: true,
                                        format: "point.x : point.y",
                                        header: selectedChartType),
                                    primaryXAxis: DateTimeAxis(),
                                    series: [
                                      // Renders line chart
                                      LineSeries<energyData, DateTime>(
                                          dataSource: chartData,
                                          xValueMapper: (value, _) =>
                                              value.month,
                                          yValueMapper: (value, _) =>
                                              value.unit)
                                    ])),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          // height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "Filters",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0),
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
                                      hint: Text(selectedService),
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
                                          selectedService = value!;
                                          if (selectedService == "All") {
                                            view = viewAll;
                                            chartType = chartTypeAll;
                                          } else {
                                            chartType = chartTypeNormal;
                                          }
                                        });
                                      },
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
                                      "Select Chart Type:",
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
                                      hint: Text(selectedChartType),
                                      isExpanded: true,
                                      underline: Container(
                                        height: 0,
                                      ),
                                      items: chartType.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedChartType = value!;
                                          setChartTypeIndex =
                                              chartType.indexOf(value);
                                          if (setChartTypeIndex == 2 ||
                                              setChartTypeIndex == 3) {
                                            view = viewPie;
                                          } else {
                                            view = viewLine;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 28.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Select View:",
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
                                      hint: Text(selectedView),
                                      isExpanded: true,
                                      underline: Container(
                                        height: 0,
                                      ),
                                      items: view.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedView = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: selectedView != "Yearly",
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Select Year:",
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
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
                                            hint: Text(selectedYear),
                                            isExpanded: true,
                                            underline: Container(
                                              height: 0,
                                            ),
                                            items: year.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedYear = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: selectedView != "Yearly" &&
                                      selectedView != "Monthly",
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Select Month:",
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
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
                                            hint: Text(selectedMonth),
                                            isExpanded: true,
                                            underline: Container(
                                              height: 0,
                                            ),
                                            items: month.map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedMonth = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // try {
                                    Dio dio = Dio();
                                    dio.options.headers[
                                        'ngrok-skip-browser-warning'] = '69420';
                                    // print(
                                    //     '${baseUrl}u/mu/${chartType.indexOf(selectedChartType)}/${responseBackup["data"][serviceData.indexWhere((element) => element == selectedService)]["locID"]}/$selectedYear');
                                    var s = "mu";
                                    if (selectedView == "Yearly") {
                                      s = "yu";
                                    } else if (selectedView == "Monthly") {
                                      s = "mu";
                                    } else {
                                      s = "du";
                                    }
                                    var response;
                                    if (s == "du") {
                                      response = await dio.get(
                                        '${baseUrl}u/${s}/${chartType.indexOf(selectedChartType)}/${(selectedService == "All") ? "0" : responseBackup["data"][serviceData.indexWhere((element) => element == selectedService) - 1]["locID"]}/$selectedYear/$selectedMonth',
                                        options: Options(headers: {
                                          HttpHeaders.contentTypeHeader:
                                              "application/json",
                                          HttpHeaders.authorizationHeader:
                                              "Bearer $jwt"
                                        }),
                                      );
                                    } else if (s == "mu") {
                                      response = await dio.get(
                                        '${baseUrl}u/${s}/${chartType.indexOf(selectedChartType)}/${(selectedService == "All") ? "0" : responseBackup["data"][serviceData.indexWhere((element) => element == selectedService) - 1]["locID"]}/$selectedYear',
                                        options: Options(headers: {
                                          HttpHeaders.contentTypeHeader:
                                              "application/json",
                                          HttpHeaders.authorizationHeader:
                                              "Bearer $jwt"
                                        }),
                                      );
                                    } else {
                                      response = await dio.get(
                                        '${baseUrl}u/${s}/${chartType.indexOf(selectedChartType)}/${(selectedService == "All") ? "0" : responseBackup["data"][serviceData.indexWhere((element) => element == selectedService) - 1]["locID"]}',
                                        options: Options(headers: {
                                          HttpHeaders.contentTypeHeader:
                                              "application/json",
                                          HttpHeaders.authorizationHeader:
                                              "Bearer $jwt"
                                        }),
                                      );
                                    }
                                    // var response = await dio.get(
                                    //   '${baseUrl}u/${s}/${chartType.indexOf(selectedChartType)}/${(selectedService == "All") ? "0" : responseBackup["data"][serviceData.indexWhere((element) => element == selectedService)]["locID"]}/$selectedYear',
                                    // );
                                    print(response.data);
                                    if (response.data["status"]) {
                                      setData(response.data);
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text("Device Added Successfully"),
                                      //   ),
                                      // );
                                      // Navigator.pushReplacement(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => MyHomePage()),
                                      // );
                                    } else {
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text("Device Already Exists"),
                                      //   ),
                                      // );
                                    }
                                    // } catch (e) {
                                    //   print(e);
                                    // }
                                  },
                                  child: Text("Show"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// @override
//     Widget build(BuildContext context) {
//         final List<SalesData> chartData = [
//             SalesData(2010, 35),
//             SalesData(2011, 28),
//             SalesData(2012, 34),
//             SalesData(2013, 32),
//             SalesData(2014, 40)
//         ];

//         return Scaffold(
//             body: Center(
//                 child: Container(
//                     child: SfCartesianChart(
//                         primaryXAxis: DateTimeAxis(),
//                         series: <ChartSeries>[
//                             // Renders line chart
//                             LineSeries<SalesData, DateTime>(
//                                 dataSource: chartData,
//                                 xValueMapper: (SalesData sales, _) => sales.year,
//                                 yValueMapper: (SalesData sales, _) => sales.sales
//                             )
//                         ]
//                     )
//                 )
//             )
//         );
//     }

class energyData {
  energyData(this.unit, this.month);
  final double unit;
  final DateTime month;
}

class applicaneData {
  applicaneData(this.xData, this.yData);
  final String xData;
  final num yData;
}
