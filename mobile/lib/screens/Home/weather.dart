import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherIcon extends StatefulWidget {
  @override
  _WeatherIconState createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon> {
  String temp;
  String icon;
  bool loading = true, error = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        loading = true;
        error = false;
      });
      // Position position = await Geolocator.getLastKnownPosition();
      // int lat = position.latitude as int, lon = position.longitude as int;

      // Fluttertoast.showToast(msg: '$lat - $lon');
      Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?id=95446&appid=df241ce5d8e2b1cf9d5901465f644eb5&units=metric',
      );
      http.Response value = await http.get(uri);
      dynamic json = jsonDecode(value.body);
      String iconImg = json["weather"][0]["icon"];

      setState(() {
        loading = false;
        temp = json["weather"][0]["main"];

        icon = 'http://openweathermap.org/img/wn/$iconImg.png';
      });
    } catch (ex) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            )
          : error
              ? IconButton(
                  icon: Icon(Icons.replay_outlined),
                  onPressed: () {
                    fetchData();
                    Fluttertoast.showToast(msg: '$temp ');
                  })
              : InkWell(
                  onTap: () => fetchData(),
                  child: Column(
                    children: [
                      Image.network(icon, width: 60),
                      Text(
                        '$temp',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          // fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
