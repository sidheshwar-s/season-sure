import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:season_sure/app/data/models/aqi_model.dart';
import 'package:season_sure/app/data/models/current_weather_model.dart';
import 'package:season_sure/app/data/models/station_model.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  d.Dio dio = d.Dio();
  final isLoading = false.obs;
  Rxn<CurrentWeatherModel> currentWeather = Rxn<CurrentWeatherModel>();
  Rxn<StationsModel> stationModel = Rxn<StationsModel>();
  Position? currentPosition;
  Rxn<AqiModel> aqi = Rxn<AqiModel>();
  String? accessToken;
  String? plot;

  @override
  void onInit() async {
    super.onInit();
    await getAccessToken();
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
      const accuApiKey = "vnOmpbV5e1pG6x0sPf8L2RhScG7bcEWz";
      double lat = currentPosition!.latitude;
      double long = currentPosition!.longitude;
      log("Latitude is $lat");
      log("Longitude is $long");
      final d.Response response = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric");

      currentWeather.value = CurrentWeatherModel.fromJson(response.data);
      log("current temp is ${currentWeather.value?.main?.temp}");
      int timeNow = DateTime.now().toUtc().microsecondsSinceEpoch;

      log("Getting aqi details");
      d.Response res = await dio.get(
          "http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lat&lon=$long&appid=$apiKey");
      aqi.value = AqiModel.fromJson(res.data);

      log("Getting safety Details");
      await getSafetyDetails(lat, long);

      d.Response resp = await dio.get(
          "https://www.worldtides.info/api/v3?heights&plot&date=2023-01-18&days=1&lat=$lat&lon=$long&key=3b2e5d17-2db7-4afb-b703-36f84bd211c5");

      plot = resp.data['plot'];
      final arr = plot?.split(",");
      plot = arr?[1];

      d.Response stationResponse = await dio.get(
        "https://www.worldtides.info/api/v3?stations&lat=$lat&lon=$long&stationDistance=50&key=3b2e5d17-2db7-4afb-b703-36f84bd211c5",
      );

      stationModel.value = StationsModel.fromJson(stationResponse.data);
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
    isLoading.value = false;
  }

  getAccessToken() async {
    d.Dio dio = d.Dio();
    d.Response res = await dio.post(
        "https://test.api.amadeus.com/v1/security/oauth2/token",
        options: d.Options(contentType: "application/x-www-form-urlencoded"),
        data: {
          "grant_type": "client_credentials",
          "client_id": "Kw5yMd6GGLm04UNtXNesWtSlqeD6Ur6e",
          "client_secret": "gJa9HM1aG9QD7ptA",
        });
    log("Access token is ${res.data["access_token"]}");
    accessToken = res.data["access_token"];
  }

  getSafetyDetails(double lat, double long) async {
    d.Dio dio = d.Dio();
    d.Response response = await dio.get(
      "https://test.api.amadeus.com/v1/safety/safety-rated-locations?latitude=$lat&longitude=$long&radius=1&page%5Blimit%5D=10&page%5Boffset%5D=0",
      options: d.Options(headers: {
        "Authorization": "Bearer $accessToken",
      }),
    );
    print(response.data);
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
