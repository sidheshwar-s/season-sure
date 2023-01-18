import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:season_sure/app/data/models/current_weather_model.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  d.Dio dio = d.Dio();
  CurrentWeatherModel? currentWeather;
  Position? currentPosition;

  @override
  void onInit() async {
    super.onInit();
    await fetchData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> fetchData() async {
    try {
      currentPosition = await getCurrentPosition();
      const apiKey = "18fe13cbd4c615fb741b2b8800412029";
      double lat = currentPosition!.latitude;
      double long = currentPosition!.longitude;
      log("Latitude is $lat");
      log("Longitude is $long");
      final d.Response response = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey");
      print(response);
      currentWeather = CurrentWeatherModel.fromJson(response.data);
      log("current temp is ${currentWeather?.main?.temp}");
    } catch (e) {
      print(e);
      Get.snackbar(
        e.toString(),
        "message",
        padding: const EdgeInsets.all(20),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[400],
      );
    }
  }
}

Future<Position> getCurrentPosition() async {
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
