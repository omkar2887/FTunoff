// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/Stat_Card.dart';

class GoToNext extends StatelessWidget {
  final String country,
      cases,
      deaths,
      recovered,
      active,
      todaydeaths,
      todaycases;
  const GoToNext(this.country, this.cases, this.deaths, this.recovered,
      this.active, this.todaydeaths, this.todaycases);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Total Cases : " + cases),
          Text("Total Deaths : " + deaths),
          Text("Total Recovered : " + recovered),
          Text("Active Today : " + active),
          Text("Total Recovered : " + todaydeaths),
          Text("Cases Today : " + todaycases),
        ],
      ),
    );
  }
}
