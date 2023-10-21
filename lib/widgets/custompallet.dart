import 'package:flutter/material.dart';
import 'package:weather_app/HomeScreen.dart';

class custompallet extends StatelessWidget {
  final String image;
  final String text;
  final String text2;
  custompallet(
      {super.key,
      required this.text,
      required this.image,
      required this.text2});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Image.asset(
          image,
          height: 60,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 5,
            ),
            Text(text2,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 17))
          ],
        )
      ],
    );
  }
}
