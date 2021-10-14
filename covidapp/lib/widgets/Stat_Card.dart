// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stat_Card extends StatelessWidget {
  final String datatype, data;

  const Stat_Card(this.datatype, this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(datatype),
            Text(data),
          ],
        ),
      ),
    );
  }
}
