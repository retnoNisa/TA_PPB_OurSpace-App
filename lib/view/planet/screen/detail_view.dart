import 'package:flutter/material.dart';
import 'package:our_space/view_model/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../model/favorite_model.dart';
import '../../../utils/state/my_state.dart';
import '../widget/detail_container.dart';
import '../../../view_model/planet_provider.dart';

class DetailView extends StatefulWidget {
  final int indexPlanet;

  const DetailView({super.key, required this.indexPlanet});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanetProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: context.read<PlanetProvider>().planets.isEmpty
          ? AppBar(
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
            )
          : AppBar(
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
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Consumer<DbProvider>(builder: (context, value, _) {
                    final planet = provider.planets[widget.indexPlanet];
                    final planetImg = provider.planetImg[widget.indexPlanet];
                    for (var element in value.favoriteModels) {
                      if (element.name == planet.name) {
                        planet.isFavorite = true;
                      }
                    }

                    return IconButton(
                      splashRadius: 25,
                      onPressed: () async {
                        if (value.favoriteModels.isEmpty) {
                          await value.addFavorite(FavoriteModel(
                            name: planet.name,
                            planetImg: planetImg,
                            idPlanet: planet.id,
                          ));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Center(
                                    child:
                                        Text('Added To Your Favorite List!')),
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                            );
                          }
                        } else {
                          for (var element in value.favoriteModels) {
                            if (element.name == planet.name) {
                              planet.isFavorite = true;
                            }
                          }
                          if (planet.isFavorite == false) {
                            await value.addFavorite(FavoriteModel(
                              name: planet.name,
                              planetImg: planetImg,
                              idPlanet: planet.id,
                            ));
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Center(
                                      child:
                                          Text('Added To Your Favorite List!')),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                ),
                              );
                            }
                          } else {
                            await value.deleteFavorite(
                              planet.id,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Center(
                                      child: Text(
                                          'Removed From Your Favorite List!')),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.5),
                                ),
                              );
                            }
                          }
                        }

                        provider.favPlanet(widget.indexPlanet);
                      },
                      icon: planet.isFavorite == true
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            )
                          : const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 30,
                            ),
                    );
                  }),
                ),
              ],
            ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/bg.png",
              fit: BoxFit.cover,
            ),
          ),
          Consumer<PlanetProvider>(builder: (context, values, _) {
            if (values.myState == MyState.loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent[100],
                ),
              );
            } else if (values.myState == MyState.failed) {
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
            } else if (values.myState == MyState.success) {
              final planet = values.planets[widget.indexPlanet];
              final planetImg = values.planetImg[widget.indexPlanet];
              final planetNickname = values.planetNickname[widget.indexPlanet];
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 3,
                          )
                        ],
                      ),
                      child: Hero(
                        tag: "PlanetName",
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
                        planetNickname,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Hero(
                      tag: "PlanetTag",
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(planetImg),
                            fit: BoxFit.contain,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 41, 78, 152)
                                  .withOpacity(0.6),
                              blurRadius: 150,
                              spreadRadius: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 41, 78, 152)
                                .withOpacity(0.6),
                            blurRadius: 150,
                            spreadRadius: 10,
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 15, right: 15),
                        child: Column(
                          children: [
                            Text(
                              textAlign: TextAlign.justify,
                              planet.description,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 136, 178, 246),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 30),

                            //Planet Order
                            DetailContainer(
                              planet: planet.planetOrder.toString(),
                              detailTitle: "Planet's Order",
                              icon: Icons.auto_mode_rounded,
                            ),
                            const SizedBox(height: 20),

                            //Volume
                            DetailContainer(
                              planet: planet.basicDetails.volume,
                              detailTitle: "Volume",
                              icon: Icons.rotate_left_rounded,
                            ),
                            const SizedBox(height: 20),

                            //Mass
                            DetailContainer(
                              planet: planet.basicDetails.mass,
                              detailTitle: "Mass",
                              icon: Icons.scale_rounded,
                            ),
                            const SizedBox(height: 30),

                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  const Text(
                                    'Source: ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        await launchUrlString(planet.wikiLink);
                                      } catch (err) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Center(
                                                  child: Text(
                                                      'Something Went Wrong')),
                                              duration:
                                                  const Duration(seconds: 1),
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      planet.wikiLink,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
