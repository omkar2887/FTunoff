// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Stat_Card.dart';

class Stat {
  final cases;
  final deaths;
  final recovered;
  final todayactive;
  final todaydeaths;
  final todaycases;
  Stat(
      {this.cases,
      this.deaths,
      this.recovered,
      this.todayactive,
      this.todaydeaths,
      this.todaycases});
}

class WorldData extends StatefulWidget {
  @override
  _WorldData createState() => _WorldData();
}

class _WorldData extends State<WorldData> {
  Stat stat = Stat(
    cases: null,
    deaths: null,
    recovered: null,
    todayactive: null,
    todaydeaths: null,
    todaycases: null,
  );

  void getStats() async {
    var url =
        Uri.parse("https://coronavirus-19-api.herokuapp.com/countries/world");

    var response = await http.get(url);

    var responseData = jsonDecode(response.body);
    setState(() {
      Stat obj = Stat(
        cases: responseData["cases"],
        deaths: responseData["deaths"],
        recovered: responseData["recovered"],
        todayactive: responseData["active"],
        todaydeaths: responseData["todayDeaths"],
        todaycases: responseData["todayCases"],
      );

      stat = obj;
    });
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.only(top: 15, right: 5, left: 5, bottom: 5),
            child: Text(
              "World Statistics",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontStyle: FontStyle.normal),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stat_Card(
                  "Total Cases", stat.cases.toString(), Colors.deepOrange),
              Stat_Card("Total Recovered", stat.recovered.toString(),
                  Colors.greenAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stat_Card(
                  "Total Deaths", stat.deaths.toString(), Colors.redAccent),
              Stat_Card("Active", stat.todayactive.toString(),
                  Colors.deepOrangeAccent),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stat_Card("Deaths Today", stat.todaydeaths.toString(),
                  Colors.redAccent),
              Stat_Card("Cases Today", stat.todaycases.toString(),
                  Colors.deepOrangeAccent),
            ],
          )
        ],
      ),
    );
  }
}
