import 'package:mobile/const/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData {
  final paiChartSelectionDatas = [
    PieChartSectionData(
      color: cardBackgroundColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: const Color(0xFF26E5FF),
      value: 20,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: const Color(0xFF9575CD),
      value: 10,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: const Color(0xFFFFFFFF),
      value: 15,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: cardBackgroundColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
  ];
}
