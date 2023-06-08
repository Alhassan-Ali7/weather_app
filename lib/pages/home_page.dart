import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';


class HomePage extends StatelessWidget{
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {

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
                    return const SearchPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState){
            return const Center(child: CircularProgressIndicator(),);
          }else if (state is WeatherSuccessState) {
            return SearchResult(weatherData: BlocProvider.of<WeatherCubit>(context).weatherModel);
          } else if (state is WeatherFailureState){
            return const Center(child: Text('Something went wrong please try again'),);
          }else{
            return Center(
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
                );
          }
        },
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  const SearchResult({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
          color: Colors.cyanAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3,),
              Text(
                BlocProvider.of<WeatherCubit>(context).cityName!,
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
    );
  }
}
