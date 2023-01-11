import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mother_fetal_ecg/widgets/CircularProgress.dart';
import 'package:mother_fetal_ecg/widgets/graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String output = "NORMAL";
  double value = 0;

  void callAPI() async {
    try {
      Uri baseUrl = Uri.parse('http://192.168.0.168/output');
      var res = await http.get(baseUrl);
      var data = jsonDecode(res.body);
      setState(() {
        value = data['ecg'];
      });
    } on Exception catch (e) {
      print("Sensor is not connected properly");
    }
  }

  // void checkingOutput() {
  //   if (temperature >= 25 && temperature <= 35) {
  //     setState(() {
  //       output = "NORMAL";
  //       outputColor = Colors.green;
  //     });
  //   } else if (temperature > 30) {
  //     setState(() {
  //       output = "HIGH";
  //       outputColor = Colors.red;
  //     });
  //   } else if (temperature < 25) {
  //     setState(() {
  //       output = "LOW";
  //       outputColor = Colors.blue;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LIVE ECG",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircularProgress(
                  title: "Pressure",
                  value: value,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "OUTPUT   :   ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        output,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Graph(
                  temperature: getECGValue,
                  color: Colors.redAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  int getECGValue() {
    callAPI();
    return value.toInt();
  }
}
