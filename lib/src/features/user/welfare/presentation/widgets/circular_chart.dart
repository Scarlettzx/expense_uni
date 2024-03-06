import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

class CircularChartWidget extends StatelessWidget {
  final List<double> stops;
  final List<Color> colors;

  const CircularChartWidget({
    super.key,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: SfCircularChart(
            series: <CircularSeries>[
              RadialBarSeries<ChartData, String>(
                maximumValue: (100).toDouble(),
                trackBorderWidth: 30,
                innerRadius: "69%",
                dataSource: [
                  ChartData("จำนวนเงินที่ใช่ไป", (90.00)),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                cornerStyle: CornerStyle.bothCurve,
                trackColor: Colors.grey.shade100,
                legendIconType: LegendIconType.circle,
                radius: '130%',
              ),
            ],
            onCreateShader: (ChartShaderDetails chartShaderDetails) {
              return ui.Gradient.sweep(
                chartShaderDetails.outerRect.center,
                colors,
                stops,
                TileMode.clamp,
                _degreeToRadian(0),
                _degreeToRadian(360),
                _resolveTransform(
                  chartShaderDetails.outerRect,
                  ui.TextDirection.ltr,
                ),
              );
            },
            tooltipBehavior: TooltipBehavior(
              color: Colors.white,
              enable: true,
              textStyle: TextStyle(
                color: Colors.black,
              ),
            ),
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: const PhysicalModel(
                  shape: BoxShape.circle,
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: SizedBox(
                    height: 130,
                    width: 130,
                  ),
                ),
              ),
              CircularChartAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ใช้ไป (บาท)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff757575),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('50,000.00'),
              Text('วงเงินทั้งหมด (บาท)'),
            ],
          ),
        ),
      ],
    );
  }

  double _degreeToRadian(int deg) => deg * (3.141592653589793 / 180);
  Float64List _resolveTransform(Rect bounds, ui.TextDirection textDirection) {
    final GradientTransform transform = GradientRotation(_degreeToRadian(-90));
    return transform.transform(bounds, textDirection: textDirection)!.storage;
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
