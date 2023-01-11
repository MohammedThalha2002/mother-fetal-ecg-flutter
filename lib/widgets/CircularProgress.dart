import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularProgress extends StatefulWidget {
  final String title;
  final double value;
  const CircularProgress({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  State<CircularProgress> createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width / 2.5,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        title: GaugeTitle(
            text: widget.title,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        axes: [
          RadialAxis(
            offsetUnit: GaugeSizeUnit.factor,
            // radiusFactor: 0.5,
            showTicks: false,
            showLabels: false,
            axisLineStyle: AxisLineStyle(
              cornerStyle: CornerStyle.bothCurve,
            ),
            annotations: [
              GaugeAnnotation(
                widget: Text(
                  widget.value.toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
            pointers: [
              RangePointer(
                value: widget.value,
                enableAnimation: true,
                cornerStyle: CornerStyle.bothCurve,
                gradient: SweepGradient(
                  colors: const <Color>[
                    Color(0xFF30B32D),
                    Color(0xFFFFDD00),
                    Colors.red,
                  ],
                  stops: const <double>[
                    0,
                    0.5833333,
                    0.777777,
                  ],
                ),
              ),
              MarkerPointer(
                value: widget.value,
                enableAnimation: true,
                markerType: MarkerType.circle,
                markerWidth: 15,
                markerHeight: 15,
                color: Colors.white,
              ),
            ],
            ranges: [
              GaugeRange(
                startValue: 0,
                endValue: 5000,
                color: Color(0xff2D2D2D),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
