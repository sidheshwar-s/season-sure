import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:season_sure/app/data/models/aqi_model.dart';
import 'package:season_sure/app/data/models/current_weather_model.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  d.Dio dio = d.Dio();
  final isLoading = false.obs;
  Rxn<CurrentWeatherModel> currentWeather = Rxn<CurrentWeatherModel>();
  Position? currentPosition;
  Rxn<AqiModel> aqi = Rxn<AqiModel>();

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
    isLoading.value = true;
    try {
      currentPosition = await getCurrentPosition();
      const apiKey = "18fe13cbd4c615fb741b2b8800412029";
      double lat = currentPosition!.latitude;
      double long = currentPosition!.longitude;
      log("Latitude is $lat");
      log("Longitude is $long");
      final d.Response response = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric");

      currentWeather.value = CurrentWeatherModel.fromJson(response.data);
      log("current temp is ${currentWeather.value?.main?.temp}");
      isLoading.value = false;
      int timeNow = DateTime.now().toUtc().microsecondsSinceEpoch;
      print(timeNow);
      log("Getting aqi details");
      d.Response res = await dio.get(
          "http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lat&lon=$long&appid=$apiKey");
      aqi.value = AqiModel.fromJson(res.data);
      print(aqi.value?.list?.first?.main?.aqi);
      print(aqi.value?.list?.first?.components?['co']);
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
