import 'package:electricity/services/general%20services/helpers.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Charts({Key? key}) : super(key: key);

  @override
  ChartsState createState() => ChartsState();
}

class ChartsState extends State<Charts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Usage History'),
        ),
        body: Chart(electricityData: ElectricityData, waterData: WaterData));
  }
}

List<ElectricityUsageData> ElectricityData = [
  ElectricityUsageData('Jan', 35),
  ElectricityUsageData('Feb', 28),
  ElectricityUsageData('Mar', 34),
  ElectricityUsageData('Apr', 32),
  ElectricityUsageData('May', 100)
];

List<WaterUsageData> WaterData = [
  WaterUsageData('Jan', 200),
  WaterUsageData('Feb', 60),
  WaterUsageData('Mar', 20),
  WaterUsageData('Apr', 30),
  WaterUsageData('May', 60)
];

class Chart extends StatelessWidget {
  Chart({
    Key? key,
    required this.electricityData,
    required this.waterData,
  }) : super(key: key);

  final List<ElectricityUsageData> electricityData;
  final List<WaterUsageData> waterData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Container(
            color: ColorConstants.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  color: ColorConstants.white,
                  child:const Row(
                    children: [
                                      Text("Usage chart",style: TextStyles.heading,),
                                      Spacer(),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "-", style: TextStyles.electricity),
                                TextSpan(
                                  text: "Electricity",
                                  style: TextStyles.normalText,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: "-", style: TextStyles.water),
                                TextSpan(
                                  text: "Water",
                                  style: TextStyles.normalText,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SfCartesianChart(
          
          backgroundColor: ColorConstants.white,
          primaryXAxis: CategoryAxis(),
          legend: Legend(
            isVisible: false,
            isResponsive: true,
          ),
          tooltipBehavior: TooltipBehavior(enable: false),
          isTransposed: false,
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enablePinching: true,
          ),
          series: <ChartSeries>[
            LineSeries<ElectricityUsageData, String>(
              color: ColorConstants.teal,
              dataSource: electricityData,
              xValueMapper: (ElectricityUsageData sales, _) => sales.year,
              yValueMapper: (ElectricityUsageData sales, _) => sales.sales,
              name: 'Electricity usage',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
            LineSeries<WaterUsageData, String>(
              color: ColorConstants.blue,
              dataSource: waterData,
              xValueMapper: (WaterUsageData sales, _) => sales.year,
              yValueMapper: (WaterUsageData sales, _) => sales.sales,
              name: 'Water usage',
              dataLabelSettings: DataLabelSettings(isVisible: true),
            ),
          ],
        ),
        ElevatedButton(onPressed: (){}, child: const Text("View usage"))
      ],
    );
  }
}class ElectricityUsageData {
  ElectricityUsageData(this.year, this.sales);

  final String year;
  final double sales;
}

class WaterUsageData {
  WaterUsageData(this.year, this.sales);

  final String year;
  final double sales;
}
