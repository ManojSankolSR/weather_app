import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/custompallet.dart';
import 'package:weather_app/widgets/sidebar.dart';

final formatterfordayname = DateFormat('EEEE');
final formatterfordaynum = DateFormat('d');
final formatterfortime = DateFormat('h:mm a');

class HomeScreen extends StatefulWidget {
  final Weather weatherdata;
  final String image;
  final Future<Weather> Function() getdata;
  HomeScreen(
      {super.key,
      required this.weatherdata,
      required this.image,
      required this.getdata});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _Scaffoldkey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer:
          sidebar(weatherdata: widget.weatherdata, Scaffoldkey: _Scaffoldkey),
      key: _Scaffoldkey,
      body: RefreshIndicator(
        onRefresh: () => widget.getdata(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  color: Colors.yellow[800],
                  height: 250,
                ),
              ),
              Positioned(
                top: 250,
                left: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  color: Color.fromRGBO(148, 11, 146, 1),
                  height: 250,
                  width: MediaQuery.of(context).size.width * .9,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () =>
                                _Scaffoldkey.currentState!.openDrawer(),
                            child: Image.asset(
                              "lib/Assets/images/menu.png",
                              height: 40,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                "📍${widget.weatherdata!.areaName!}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              Text(
                                "Good Morning",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      Align(
                        child: Container(
                          // color: Colors.red,
                          child: Image.asset(
                            widget.image,
                            height: 350,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        child: Text(
                          "${widget.weatherdata!.temperature!.celsius!.round()}\u00b0C",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 55,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Align(
                        child: Text(
                          widget.weatherdata!.weatherDescription!.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Align(
                        child: Text(
                          "${formatterfordayname.format(widget.weatherdata!.date!)} ${formatterfordaynum.format(widget.weatherdata!.date!)} - ${formatterfortime.format(widget.weatherdata!.date!)}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(height: 50),
                      MediaQuery.of(context).size.width >= 340
                          ? Row(
                              children: [
                                Spacer(),
                                custompallet(
                                  text: "sunrise",
                                  image: "lib/Assets/images/sun.png",
                                  text2: formatterfortime
                                      .format(widget.weatherdata!.sunrise!)
                                      .toLowerCase(),
                                ),
                                Spacer(),
                                custompallet(
                                    text: "sunset",
                                    image: "lib/Assets/images/moon.png",
                                    text2: formatterfortime
                                        .format(widget.weatherdata!.sunset!)
                                        .toLowerCase()),
                                Spacer(),
                              ],
                            )
                          : Column(children: [
                              SizedBox(
                                height: 20,
                              ),
                              custompallet(
                                text: "sunrise",
                                image: "lib/Assets/images/sun.png",
                                text2: formatterfortime
                                    .format(widget.weatherdata!.sunrise!)
                                    .toLowerCase(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              custompallet(
                                  text: "sunset",
                                  image: "lib/Assets/images/moon.png",
                                  text2: formatterfortime
                                      .format(widget.weatherdata!.sunset!)
                                      .toLowerCase()),
                            ]),
                      SizedBox(
                        height: 30,
                      ),
                      MediaQuery.of(context).size.width >= 340
                          ? Row(
                              children: [
                                Spacer(),
                                custompallet(
                                  text: "Temp Max",
                                  image: "lib/Assets/images/maxtemp.png",
                                  text2:
                                      "${widget.weatherdata!.tempMax!.celsius!.round()}\u00b0C",
                                ),
                                Spacer(),
                                custompallet(
                                  text: "Temp Min",
                                  image: "lib/Assets/images/mintemp.png",
                                  text2:
                                      "${widget.weatherdata!.tempMin!.celsius!.round()}\u00b0C",
                                ),
                                Spacer(),
                              ],
                            )
                          : Column(
                              children: [
                                // Spacer(),

                                custompallet(
                                  text: "Temp Max",
                                  image: "lib/Assets/images/maxtemp.png",
                                  text2:
                                      "${widget.weatherdata!.tempMax!.celsius!.round()}\u00b0C",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                custompallet(
                                  text: "Temp Min",
                                  image: "lib/Assets/images/mintemp.png",
                                  text2:
                                      "${widget.weatherdata!.tempMin!.celsius!.round()}\u00b0C",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
