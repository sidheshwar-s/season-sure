import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:season_sure/app/data/constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          backgroundColor: backgroundColor,
          expandedHeight: 150.0,
          floating: true,
          pinned: true,
          snap: false,
          centerTitle: true,
          title: const Text(
            'SeasonSure',
            style: TextStyle(fontSize: 25),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Padding(
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
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: foregroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.white),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 40),
                    child: Row(
                      children: const [
                        Text(
                          "Today",
                          style: TextStyle(fontSize: 30),
                        ),
                        Spacer(),
                        Text(
                          "10th March",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 40),
                        child: Text(
                          "30",
                          style: TextStyle(fontSize: 70),
                        ),
                      ),
                      Text(
                        "°C",
                        style: TextStyle(color: accentColor, fontSize: 25),
                      ),
                      Spacer(),
                      Icon(
                        Icons.web_asset,
                        size: 100,
                      )
                    ],
                  ),
                  const Text("The loction is in Chennai and let us have fun"),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_location,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Chennai,TamilNadu"),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
