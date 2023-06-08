import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/services/weather_service.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
      BlocProvider(
        create: (context) {
          return WeatherCubit(WeatherService());
        },
        child: const MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
  );
}


