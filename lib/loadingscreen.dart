import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/HomeScreen.dart';

class loadingScreen extends StatefulWidget {
  loadingScreen({super.key});

  @override
  State<loadingScreen> createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  String image = '';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<Weather> getdata() async {
    print("entered getdata");
   
    final location = await _determinePosition();

    WeatherFactory wf = WeatherFactory("e42628ff58a8a6f124b219f37fc52db9",
        language: Language.ENGLISH);

    final weatherdata =
        await wf.currentWeatherByLocation(location.latitude, location.longitude);
 
    setimage(weatherdata!.weatherConditionCode!);
   
    return weatherdata;
  }

  void setimage(int weathercode) {
    if (weathercode >= 200 && weathercode <= 232) {
      setState(() {
        image = "lib/Assets/images/storm.png";
      });
    }
    if (weathercode >= 300 && weathercode <= 321) {
      setState(() {
        image = "lib/Assets/images/drizzel.png";
      });
    }
    if (weathercode >= 500 && weathercode <= 531) {
      setState(() {
        image = "lib/Assets/images/fastrain.png";
      });
    }
    if (weathercode >= 600 && weathercode <= 622) {
      setState(() {
        image = "lib/Assets/images/snow.png";
      });
    }
    if (weathercode >= 701 && weathercode <= 781) {
      setState(() {
        image = "lib/Assets/images/5.png";
      });
    }
    if (weathercode == 800) {
      setState(() {
        image = "lib/Assets/images/clear.png";
      });
    }
    if (weathercode >= 801 && weathercode <= 804) {
      setState(() {
        image = "lib/Assets/images/cloud.png";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: getdata(),
      builder: (context, snapshot) {
        
        if (snapshot.hasData) {
          return HomeScreen(
            weatherdata: snapshot.data!,
            image: image,
            getdata: getdata,
          );
        }
        return Center(
          child: LottieBuilder.asset("lib/Assets/images/laodingScreen.json",
              frameRate: FrameRate.max),
        );
      },
    );
  }
}
