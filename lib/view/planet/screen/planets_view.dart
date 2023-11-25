import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:our_space/view/planet/screen/detail_view.dart';
import 'package:provider/provider.dart';

import '../../../utils/state/my_state.dart';
import '../../../view_model/planet_provider.dart';

class PlanetsView extends StatefulWidget {
  const PlanetsView({super.key});

  @override
  State<PlanetsView> createState() => _PlanetsViewState();
}

class _PlanetsViewState extends State<PlanetsView> {
  ScrollController scrollC = ScrollController();

  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final provider = Provider.of<PlanetProvider>(context, listen: false);

        provider.fetchPlanet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Hero(
              tag: "LogoTag",
              child: Image.asset(
                width: 45,
                "assets/images/icon.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Consumer<PlanetProvider>(
            builder: (context, value, _) {
              if (value.myState == MyState.loading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.blueAccent[100],
                ));
              } else if (value.myState == MyState.failed) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Oops, Something Went Wrong!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        textAlign: TextAlign.center,
                        'Make Sure Internet is Connected.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (value.myState == MyState.success) {
                return Column(
                  children: [
                    const SizedBox(height: 60),
                    Expanded(
                      child: CarouselSlider.builder(
                        itemCount: value.planetImg.length,
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          enlargeCenterPage: true,
                          viewportFraction: 1.1,
                          onPageChanged: (index, reason) {
                            value.changePage(index);
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          final planet = value.planets[index];
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Hero(
                                      tag: "PlanetName",
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              blurRadius: 30,
                                              spreadRadius: 3,
                                            )
                                          ],
                                        ),
                                        child: Text(
                                          planet.name.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 50,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: "PlanetNickname",
                                      child: Text(
                                        value.planetNickname[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    const SizedBox(height: 100),
                                    Center(
                                      child: Hero(
                                        tag: "PlanetTag",
                                        child: Container(
                                          height: 305,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                value.planetImg[index],
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color.fromARGB(
                                                        255, 41, 78, 152)
                                                    .withOpacity(0.6),
                                                blurRadius: 150,
                                                spreadRadius: 10,
                                              )
                                            ],
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            shape: const CircleBorder(),
                                            child: InkWell(
                                              customBorder:
                                                  const CircleBorder(),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    transitionDuration:
                                                        const Duration(
                                                            seconds: 2),
                                                    pageBuilder: (context,
                                                            animations,
                                                            secondaryAnimations) =>
                                                        DetailView(
                                                            indexPlanet: index),
                                                    transitionsBuilder:
                                                        (context,
                                                            animations,
                                                            secondaryAnimations,
                                                            childs) {
                                                      final tween = Tween(
                                                          begin: 0.0, end: 1.0);
                                                      return FadeTransition(
                                                        opacity: animations
                                                            .drive(tween),
                                                        child: childs,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                value.planetImg.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () => _carouselController
                                    .animateToPage(entry.key),
                                child: Row(
                                  children: [
                                    const Text(
                                      "- -",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      width: 13.0,
                                      height: 13.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.white)
                                            .withOpacity(
                                                value.current == entry.key
                                                    ? 1.0
                                                    : 0.4),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "- - ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
