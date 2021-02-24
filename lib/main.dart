import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_app_1/GetLocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
    String city;
    @override
    Widget build(BuildContext context) {
        getLocation();
        return MaterialApp(
            home: Scaffold(
                body: Column(
                    children: [
                        Container(
                            child: displayImage(),  //Image.asset('images/green-leaf.jpg')
                        ),

                        Container(
                            margin: EdgeInsets.only(top:50.0),
                            child: Text('You are in:', style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[500]
                            ))
                        ),

                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 25.0),
                            child: Row(
                                children: [
                                    Container(
                                        child: Text(city.toString(), style: 
                                        TextStyle(
                                            color: Colors.green[500],
                                            fontSize: 27.0,
                                            fontWeight: FontWeight.bold,
                                            )
                                        )
                                    ),
                                    SizedBox(width: 10.0),
                                    Container(
                                        child: Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 35.0
                                        )
                                    )
                                ],
                                )
                        ),

                        Card(
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            color: Colors.white,
                            child: ListTile(
                                leading: Icon(
                                    Icons.wb_sunny,
                                    color: Colors.amber,
                                ),
                                title: Text(" 24 °C"), //show data from api
                            ),
                        ),

                        Card(
                            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            color: Colors.white,
                            child: ListTile(
                                leading: Icon(
                                    Icons.calendar_today,
                                    color: Colors.amber,
                                ),
                                title: Text("Date and Time"), //show data from api
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    //   display images based on current time
    displayImage(){
        var now = DateTime.now();
        final currentTime = DateFormat.jm().format(now);

        if(currentTime.contains('AM')){
            print('Current Time is: $currentTime');
            return Image.asset('images/green-leaf.jpg');
        }
        else{
            print('Current Time is: $currentTime');
            return Image.asset('images/night-leaf.jpg');
        }
    }

    // Get Location
    void getLocation() async{
        GetLocation getLocation = GetLocation();
        await getLocation.getCurrentLocation(); // await Fun

        // print(getLocation.latitude);
        // print(getLocation.longitude);
        // print(getLocation.city);

        city = getLocation.city;
    }

    // Test API
    void getData() async{
        http.Response response = await http.get('https://testoverseas-jobs.management-partners.co.jp/api/v1/jobs/1'); // await network
        // print(response.body);
        var dataDecode = jsonDecode(response.body); // convert json obj to dart obj
        // see result in terminal
        print(dataDecode);
        print(dataDecode['data']['details']['title']);
    }
    
}