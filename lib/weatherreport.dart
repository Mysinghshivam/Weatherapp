import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class weather extends StatefulWidget {
  const weather({Key? key}) : super(key: key);
  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {

  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();

  var lat;
  var lon;

  var temp;

  var press;

  var humi;


  void userInfo() async {
    String City = city.text;
    String State = state.text;
    String Country = country.text;

    final userres = await http.get(Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$City,$State,$Country&appid=35cd72c951458d99d313d5af769189aa'));
    var data = json.decode(userres.body.toString());

    lat = data[0]['lat'];
    lon = data[0]['lon'];
    print(lat);
    print(lon);
    weatherinfo();
  }

  void weatherinfo() async {
    final res = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=35cd72c951458d99d313d5af769189aa'));
    var data = json.decode(res.body.toString());
    print(data);
    print(data['main']['temp']);
    print(data['main']['pressure']);
    print(data['main']['humidity']);

    setState(() {
      temp = data['main']['temp'];
      temp = (temp - 273.15).toStringAsFixed(0);
      press = data['main']['pressure'];
      humi = data['main']['humidity'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.back)),
        title: Text(
          "Temperature,Pressure,Humidity",
          textAlign: TextAlign.justify,
        ),
      ),
      body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue.shade50,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Image.asset('assets/weather.png',width: 100,height: 100,),
                  Text(
                    "Weather report",
                    style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: 350,
                    height: 370,
                    //color: Colors.lightBlue.shade50,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                          TextField(
                            controller: city,
                            decoration:
                            InputDecoration(hintText: "City", filled: true),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: state,
                            decoration:
                            InputDecoration(hintText: "State", filled: true),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: country,
                            decoration:
                            InputDecoration(hintText: "Country", filled: true),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                userInfo();
                              },
                              child: Text('Check')),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Temperature: $temp C, Pressure: $press, Humidity: $humi",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
