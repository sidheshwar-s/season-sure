import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:season_sure/app/data/constants.dart';
import 'package:season_sure/app/data/models/aqi_model.dart';
import 'package:season_sure/app/data/models/current_weather_model.dart';
import 'package:season_sure/app/data/weather_data.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.yMMMMd('en_US').format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Obx(
          () {
            if (controller.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              CurrentWeatherModel? currentWeatherModel =
                  controller.currentWeather.value;
              String? desc =
                  controller.currentWeather.value?.weather?.first?.description;
              String? iconId =
                  controller.currentWeather.value?.weather?.first?.icon;
              String? city = controller.currentWeather.value?.name;
              String? country = controller.currentWeather.value?.sys?.country;
              double? low = controller.currentWeather.value?.main?.tempMin;
              double? high = controller.currentWeather.value?.main?.tempMax;
              int? windSpeed =
                  controller.currentWeather.value?.wind?.speed?.toInt();
              int? humidity = controller.currentWeather.value?.main?.humidity;
              AqiModel? aqiModel = controller.aqi.value;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: backgroundColor,
                    expandedHeight: 150.0,
                    floating: true,
                    pinned: true,
                    snap: false,
                    centerTitle: true,
                    title: Text(
                      'SeasonSure',
                      style: GoogleFonts.montserrat().copyWith(fontSize: 25),
                    ),
                    flexibleSpace: const FlexibleSpaceBar(
                      centerTitle: true,
                      title: SearchWidget(),
                    ),
                  ),
                  WeatherWidget(
                      date: date,
                      currentWeatherModel: currentWeatherModel,
                      iconId: iconId,
                      desc: desc,
                      high: high,
                      low: low,
                      city: city,
                      country: country,
                      windSpeed: windSpeed,
                      humidity: humidity),
                  SliverToBoxAdapter(
                    child: DefaultTextStyle(
                      style: GoogleFonts.montserrat()
                          .copyWith(color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          bottom: 20,
                          right: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Air Quality Index",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " - ${getAqiTag(aqiModel?.list?.first?.main?.aqi)}",
                                  style: const TextStyle(
                                      color: accentColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Table(
                                border: TableBorder.all(color: Colors.white),
                                children: [
                                  const TableRow(children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'CO',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'NO',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'NO₂',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'O₃',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'SO₂',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'PM₂.₅',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'PM₁₀',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        'NH₃',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['co']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['no']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['no2']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['o3']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['so2']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['pm2_5']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['pm10']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "${aqiModel?.list?.first?.components?['nh3']}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String getAqiTag(int? aqi) {
    if (aqi == 1) return "Good";
    if (aqi == 2) return "Fair";
    if (aqi == 3) return "Moderate";
    if (aqi == 4) return "Poor";
    if (aqi == 5) {
      return "Very poor";
    } else {
      return "Moderate";
    }
  }
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
    required this.date,
    required this.currentWeatherModel,
    required this.iconId,
    required this.desc,
    required this.high,
    required this.low,
    required this.city,
    required this.country,
    required this.windSpeed,
    required this.humidity,
  }) : super(key: key);

  final String date;
  final CurrentWeatherModel? currentWeatherModel;
  final String? iconId;
  final String? desc;
  final double? high;
  final double? low;
  final String? city;
  final String? country;
  final int? windSpeed;
  final int? humidity;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: DefaultTextStyle(
            style: GoogleFonts.montserrat().copyWith(color: Colors.white),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentWeatherModel?.main?.temp}",
                    style: const TextStyle(fontSize: 70),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "°C",
                      style: TextStyle(color: accentColor, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    getWeatherIconUrl(iconId!),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$desc",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text("$high° / $low°")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: accentColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("$city, $country"),
                  const Spacer(),
                  Text("🍃 $windSpeed m/s"),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("💧 $humidity%")
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          fillColor: foregroundColor,
          filled: true,
          hintStyle: GoogleFonts.montserrat().copyWith(
            color: Colors.white,
            fontSize: 13,
          ),
          hintText: 'Search Your Location',
          suffixIcon: const Icon(
            Icons.location_city,
            size: 23,
            color: Colors.white54,
          ),
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
