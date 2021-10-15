// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, deprecated_member_use, prefer_typing_uninitialized_variables, must_be_immutable, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/WorldData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'GoToNext.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  RegExp regex = RegExp(
      "((?<=(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?(?:\u200d(?:[^\ud800-\udfff]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?)*)|(?=(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?(?:\u200d(?:[^\ud800-\udfff]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?)*))");
  String? chosenCountry = null,
      chosenState = null,
      chosenCity = null,
      response = "";

  Stat stat = Stat(
    cases: null,
    deaths: null,
    recovered: null,
    todayactive: null,
    todaydeaths: null,
    todaycases: null,
  );

  void getStats(String country) async {
    var url = Uri.parse(
        "https://coronavirus-19-api.herokuapp.com/countries/$country");

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

  void getError(country) {
    setState(() {
      response = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Covid Tracker App")),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: const [
                Colors.indigo,
                Colors.blue,
                Colors.lightGreen,
              ])),
          child: Column(
            children: <Widget>[
              WorldData(),
              Container(
                margin: const EdgeInsets.only(
                    top: 20, right: 5, left: 5, bottom: 5),
                child: Text(
                  "Search by region",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Card(
                elevation: 3,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: const [
                        Colors.indigo,
                        Colors.blue,
                        Colors.lightGreen,
                      ])),
                  padding: EdgeInsets.all(20),
                  child: SelectState(
                    onCountryChanged: (value) {
                      setState(() {
                        chosenCountry = value.split(regex)[2].trim();
                        response = "";
                        getStats(chosenCountry.toString());
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        chosenState = value;
                        response = "";
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        chosenCity = value;
                        response = "";
                      });
                    },
                  ),
                ),
              ),
              Text(response.toString()),
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                  if (chosenCountry != null &&
                      chosenState != null &&
                      chosenCity != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GoToNext(
                            chosenCountry.toString(),
                            chosenState.toString(),
                            chosenCity.toString(),
                            stat.cases.toString(),
                            stat.deaths.toString(),
                            stat.recovered.toString(),
                            stat.todayactive.toString(),
                            stat.todaydeaths.toString(),
                            stat.todaycases.toString())));
                  } else if (chosenCountry == null &&
                      chosenState == null &&
                      chosenCity == null) {
                    getError("Please select Country, State, City");
                  } else if (chosenCountry != null &&
                      chosenState == null &&
                      chosenCity == null) {
                    getError("Please select State, City");
                  } else if (chosenCountry != null &&
                      chosenState != null &&
                      chosenCity == null) {
                    getError("Please select City");
                  }
                },
                child: Text("Search"),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
