import 'package:trac_manager/Bargraph/IndividualBarGraph.dart';

class BarData{
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
});

  List<individualBar> barData = [];

  void intiallizedbardata(){
    barData = [
      individualBar(x: 0, y: sunAmount,),
      individualBar(x: 1, y: monAmount,),
      individualBar(x: 2, y: tueAmount,),
      individualBar(x: 3, y: wedAmount,),
      individualBar(x: 4, y: thuAmount,),
      individualBar(x: 5, y: friAmount,),
      individualBar(x: 6, y: satAmount,),
    ];
  }
}