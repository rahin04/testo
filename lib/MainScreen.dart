import 'dart:convert';

import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late List<WeatherInfo> weatherData;

  @override
  void initState() {
    super.initState();
    final jsonString = '''
    [
      {
        "city": "New York",
        "temperature": 20,
        "condition": "Clear",
        "humidity": 60,
        "windSpeed": 5.5
      },
      {
        "city": "Los Angeles",
        "temperature": 25,
        "condition": "Sunny",
        "humidity": 50,
        "windSpeed": 6.8
      },
      {
        "city": "London",
        "temperature": 15,
        "condition": "Partly Cloudy",
        "humidity": 70,
        "windSpeed": 4.2
      },
      {
        "city": "Tokyo",
        "temperature": 28,
        "condition": "Rainy",
        "humidity": 75,
        "windSpeed": 8.0
      },
      {
        "city": "Sydney",
        "temperature": 22,
        "condition": "Cloudy",
        "humidity": 55,
        "windSpeed": 7.3
      }
    ]
    ''';

    weatherData = List<WeatherInfo>.from(
      json.decode(jsonString).map((x) => WeatherInfo.fromJson(x)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Info App'),
      ),
      body: ListView.builder(
        itemCount: weatherData.length,
        itemBuilder: (context, index) {
          WeatherInfo weatherInfo = weatherData[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              elevation: 5,
              child: ListTile(
                title: Text(weatherInfo.city),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Temperature: ${weatherInfo.temperature}°C'),
                    Text('Condition: ${weatherInfo.condition}'),
                    Text('Humidity: ${weatherInfo.humidity}%'),
                    Text('Wind Speed: ${weatherInfo.windSpeed} m/s'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WeatherInfo {
  final String city;
  final int temperature;
  final String condition;
  final int humidity;
  final double windSpeed;

  WeatherInfo({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      city: json['city'],
      temperature: json['temperature'],
      condition: json['condition'],
      humidity: json['humidity'],
      windSpeed: json['windSpeed'].toDouble(),
    );
  }
}
