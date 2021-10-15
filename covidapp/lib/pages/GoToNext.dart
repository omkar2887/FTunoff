// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, non_constant_identifier_names, unused_field

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:convert';
import '../widgets/Stat_Card.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GoToNext extends StatelessWidget {
  final String country,
      state,
      city,
      cases,
      deaths,
      recovered,
      active,
      todaydeaths,
      todaycases,
      critical,
      tests;
  const GoToNext(
      this.country,
      this.state,
      this.city,
      this.cases,
      this.deaths,
      this.recovered,
      this.active,
      this.todaydeaths,
      this.todaycases,
      this.critical,
      this.tests);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          country,
          style: const TextStyle(fontFamily: 'Nunito'),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 15, right: 5, left: 5, bottom: 5),
              child: Text(
                "Your Location : " + city.toString() + ", " + state.toString(),
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 25,
                    color: Colors.black,
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Nunito'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stat_Card("Total Cases", cases.toString(), Colors.deepOrange),
                Stat_Card("Total Recovered", recovered.toString(),
                    Colors.greenAccent),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stat_Card("Total Deaths", deaths.toString(), Colors.redAccent),
                Stat_Card("Active", active.toString(), Colors.deepOrangeAccent),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stat_Card(
                    "Deaths Today", todaydeaths.toString(), Colors.redAccent),
                Stat_Card("Cases Today", todaycases.toString(),
                    Colors.deepOrangeAccent),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stat_Card("Critical", critical.toString(), Colors.redAccent),
                Stat_Card("Total Tests", tests.toString(), Colors.greenAccent),
              ],
            ),
            MyChart(cases.toString(), deaths.toString(), recovered.toString(),
                tests.toString())
          ],
        ),
      ),
    );
  }
}

class MyChart extends StatefulWidget {
  final String Cases, Deaths, Recovered, tests;
  const MyChart(this.Cases, this.Deaths, this.Recovered, this.tests);
  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  late List<CasesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<CasesData> getChartData() {
    final List<CasesData> chartData = [
      CasesData("Total Cases", int.parse(widget.Cases)),
      CasesData("Total Deaths", int.parse(widget.Deaths)),
      CasesData("Total Recovered", int.parse(widget.Recovered)),
      CasesData("Total Tests", int.parse(widget.tests))
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
        title: ChartTitle(
            text: "Covid Statistics",
            textStyle: const TextStyle(fontFamily: 'Nunito')),
        tooltipBehavior: _tooltipBehavior,
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
          PieSeries<CasesData, String>(
              dataSource: _chartData,
              xValueMapper: (CasesData Data, _) => Data.datatype,
              yValueMapper: (CasesData Data, _) => Data.data,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
              enableTooltip: true),
        ],
      ),
    );
  }
}

class CasesData {
  CasesData(this.datatype, this.data);
  final String datatype;
  final int data;
}
