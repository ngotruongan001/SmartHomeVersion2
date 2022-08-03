import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<LiveData> chartData;
  late ChartSeriesController _chartSeriesController;


  num temperature = 0;
  num humidity = 0 ;
  @override
  void initState() {
    chartData = getChartData();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);

    final database = FirebaseDatabase.instance.reference();
    final read = database.child("/ESP32_Device");
    final getTempData = read.child("/Temperature/Data");
    final getHumiData = read.child("/Humidity/Data");
    getTempData.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("temperature}: $value");
      setState(() {
        temperature = value as num;
      });
    });
    getHumiData.onValue.listen((DatabaseEvent event) {
      var value = event.snapshot.value;
      print("humidity}: $value");
      setState(() {
        humidity = value as num;
      });
    });
    super.initState();
  }

  @override


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              width: 400,
              height: 300,
              child: SfCartesianChart(
                backgroundColor: Colors.deepOrangeAccent,
                  series: <LineSeries<LiveData, int>>[
                    LineSeries<LiveData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _chartSeriesController = controller;
                      },
                      dataSource: chartData,
                      color: const Color.fromRGBO(192, 108, 132, 1),
                      xValueMapper: (LiveData sales, _) => sales.time,
                      yValueMapper: (LiveData sales, _) => sales.speed,
                    ),
                    LineSeries<LiveData, int>(
                      onRendererCreated: (ChartSeriesController controller2) {
                        _chartSeriesController = controller2;
                      },
                      dataSource: chartData,
                      color: const Color.fromRGBO(192, 108, 132, 1),
                      xValueMapper: (LiveData sales, _) => sales.time,
                      yValueMapper: (LiveData sales, _) => sales.speed,
                    )
                  ],
                  primaryXAxis: NumericAxis(
                      majorGridLines: MajorGridLines(width: 0),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Time (seconds)')),
                  primaryYAxis: NumericAxis(
                      axisLine: AxisLine(width: 0),
                      majorTickLines: MajorTickLines(size: 0),
                      title: AxisTitle(text: 'Temperature'))),
            )));
  }

  int time = 19;
  void updateDataSource(Timer timer) {
    chartData.add(LiveData(time++, temperature));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  }

  List<LiveData> getChartData() {
    return <LiveData>[
      LiveData(0, 42),
      LiveData(1, 47),
      LiveData(2, 43),
      LiveData(3, 49),
      LiveData(4, 54),
      LiveData(5, 41),
      LiveData(6, 58),
      LiveData(7, 51),
      LiveData(8, 98),
      LiveData(9, 41),
      LiveData(10, 53),
      LiveData(11, 72),
      LiveData(12, 86),
      LiveData(13, 52),
      LiveData(14, 94),
      LiveData(15, 92),
      LiveData(16, 86),
      LiveData(17, 72),
      LiveData(18, 94)
    ];
  }
}

class LiveData {
  LiveData(this.time, this.speed);
  final int time;
  final num speed;
}