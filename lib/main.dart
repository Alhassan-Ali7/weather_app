import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) {
          return WeatherProvider();
        },
        child: MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
  );
}


