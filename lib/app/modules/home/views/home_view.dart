import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:season_sure/app/data/constants.dart';
import 'package:season_sure/app/data/models/current_weather_model.dart';
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
              return CustomScrollView(slivers: [
                const SliverAppBar(
                  backgroundColor: backgroundColor,
                  expandedHeight: 150.0,
                  floating: true,
                  pinned: true,
                  snap: false,
                  centerTitle: true,
                  title: Text(
                    'SeasonSure',
                    style: TextStyle(fontSize: 25),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
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
                        style: const TextStyle(color: Colors.white),
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
                                children: [
                                  Text(
                                    "${currentWeatherModel?.main?.temp}",
                                    style: const TextStyle(fontSize: 70),
                                  ),
                                  const Text(
                                    "°C",
                                    style: TextStyle(
                                        color: accentColor, fontSize: 25),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.web_asset,
                                    size: 100,
                                  )
                                ],
                              ),
                              const Text(
                                  "The loction is in Chennai and let us have fun"),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.add_location,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Chennai,TamilNadu"),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          fillColor: foregroundColor,
          filled: true,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 13),
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
