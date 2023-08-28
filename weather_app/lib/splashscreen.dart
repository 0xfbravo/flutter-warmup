import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/core/domain/usecases/search_location_usecase.dart';
import 'package:weather_app/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    _coldStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Center(
            child: SizedBox.square(
              dimension: 160,
              child: Lottie.asset(
                'assets/sun_loading.json',
                repeat: true,
              ),
            ),
          ),
          const Text(
            'Weather App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _coldStart() async {
    final searchLocation = GetIt.I.get<SearchLocationUseCase>();
    // Needed to rename to GB, because 'Silverstone, UK' is not found
    await searchLocation(query: 'Silverstone, GB');
    await searchLocation(query: 'São Paulo, Brazil');
    await searchLocation(query: 'Melbourne, Australia');
    await searchLocation(query: 'Monte Carlo, Monaco');
    await Get.offAll<void>(const Home());
  }
}
