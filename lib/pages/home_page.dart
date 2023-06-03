import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: weatherData == null
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'there is no weather 🥺 start',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ],
        ),
      )
          : Container(
        color: Colors.cyanAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3,),
            Text(
              Provider.of<WeatherProvider>(context).cityName!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'last updated at : ${weatherData!.date}',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  'https:${weatherData!.icon}',
                  height: 80,
                  width: 80,
                ),
                Text(
                  '${weatherData!.temp.toInt()}',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'maxTemp : ${weatherData!.maxTemp.toInt()}',
                    ),
                    Text(
                      'minTemp : ${weatherData!.minTemp.toInt()}',
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              weatherData!.weatherStateName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 5,),
          ],
        ),
      ),
    );
  }
}
