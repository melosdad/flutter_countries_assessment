import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';

class Constants {
  static final baseUrl = 'https://restcountries.eu/rest/v2/region/africa';
  static final imgUrl = 'https://flagcdn.com/w640/';
  static final searchUrl = 'https://restcountries.eu/rest/v2/alpha/';

  static Future<String> httpGetRequest(String url) async {
    Map<String, String> headers = new Map<String, String>();
    headers['Accept'] = 'application/json';
    String results;
    try {
      await http.get(url).then((response) {
        results = response.body;
      });
    } catch (e) {
      Map error = {"error": e.toString()};
      results = json.encode(error);
    }
    return results;
  }

  static moreInfo(BuildContext context, var countryData) {
    Navigator.of(context)
        .pushNamed(AppRoutes.countryDetail, arguments: countryData);
  }
}
