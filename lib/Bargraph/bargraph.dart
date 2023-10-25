import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trac_manager/Bargraph/Bardata.dart';
import 'package:trac_manager/Data/Expensedata.dart';

class BarGraph extends StatelessWidget {
  const BarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;


  @override
  Widget build(BuildContext context) {
    BarData MYbardata = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    MYbardata.intiallizedbardata();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: BarChart(BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: GetBottomTiles,
          )),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: MYbardata.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: const Color.fromRGBO(85, 86, 67, 1),
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: const Color.fromRGBO(255, 242, 216, 1))),
                ]))
            .toList(),
      )),
    );
  }

  Widget GetBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromRGBO(85, 88, 87, 1),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'Sun',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'Mon',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Tue',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'Wed',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'Thu',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'Fri',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'Sat',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
