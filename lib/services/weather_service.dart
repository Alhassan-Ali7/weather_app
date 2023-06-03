import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {

  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'c288425eaabb4f4a83b43300230306';


  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weatherModel;
    try{
      Uri url = Uri.parse(
          '$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3'
      );
      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);

      weatherModel = WeatherModel.fromJson(data);
    }catch(e){
      print(e);
    }

    return weatherModel;
  }
}
