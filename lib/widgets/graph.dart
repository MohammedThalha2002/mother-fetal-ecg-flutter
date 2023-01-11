import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Graph extends StatefulWidget {
  final int Function() temperature;
  final Color color;
  const Graph({
    Key? key,
    required this.temperature,
    required this.color,
  }) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  _GraphState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 500), _updateDataSource);
  }
  Timer? timer;
  List<ChartData>? chartData;
  late int count;
  ChartSeriesController? chartSeriesController;
  @override
  void initState() {
    count = 19;
    chartData = <ChartData>[
      ChartData(0, 0),
    ];
    super.initState();
    // );
  }

  @override
  void dispose() {
    timer?.cancel();
    chartData!.clear();
    chartSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfCartesianChart(
        enableAxisAnimation: true,
        plotAreaBorderWidth: 0,
        primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 1),
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0),
        ),
        series: <SplineSeries<ChartData, int>>[
          SplineSeries<ChartData, int>(
            animationDelay: 2,
            onRendererCreated: (ChartSeriesController controller) {
              chartSeriesController = controller;
            },
            dataSource: chartData!,
            color: widget.color,
            xValueMapper: (ChartData sales, _) => sales.sec,
            yValueMapper: (ChartData sales, _) => sales.val,
            animationDuration: 2,
          )
        ],
      ),
    );
  }

  void _updateDataSource(Timer timer) {
    chartData!.add(ChartData(count, widget.temperature()));
    if (chartData!.length == 20) {
      chartData!.removeAt(0);
      chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
      );
    }
    count = count + 1;
  }
}

class ChartData {
  ChartData(this.sec, this.val);
  final int sec;
  final num val;
}
