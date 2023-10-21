import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';

class sidebar extends StatelessWidget {
  final Weather weatherdata;
  final GlobalKey<ScaffoldState> Scaffoldkey;
  sidebar({super.key, required this.weatherdata, required this.Scaffoldkey});
  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
          // side: BorderSide(color: Colors.red)
        ),
        width: 300,
        backgroundColor: Colors.black54,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SafeArea(
                  child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Scaffoldkey.currentState!.closeDrawer();
                      },
                      icon: Icon(
                        Icons.cancel_sharp,
                        color: Colors.white,
                        size: 35,
                      )),
                ],
              )),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.maxWidth,
                    child: LottieBuilder.asset(
                      "lib/Assets/images/weather.json",
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "📍 ${weatherdata!.areaName!}",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Text(
                weatherdata!.country!,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Colors.white),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .4),
              Image.asset(
                "lib/Assets/images/flutter_logo.png",
                width: 100,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
