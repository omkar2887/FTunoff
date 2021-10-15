// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stat_Card extends StatelessWidget {
  final String datatype, data;
  final Color _mycolor;
  const Stat_Card(this.datatype, this.data, this._mycolor);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue,
      elevation: 2,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              datatype,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 25,
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
            Text(
              data,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 15,
                fontWeight: FontWeight.bold,
                color: _mycolor,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
