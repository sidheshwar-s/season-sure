import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:season_sure/app/data/constants.dart';
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
              return CustomScrollView(slivers: [
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: foregroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.montserrat()
                            .copyWith(color: Colors.white),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      style: TextStyle(
                                          color: accentColor, fontSize: 25),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                ],
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ]);
            }
          },
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
