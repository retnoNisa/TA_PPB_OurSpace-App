import 'package:flutter/material.dart';
import 'package:our_space/view/planet/screen/detail_view.dart';
import 'package:provider/provider.dart';
import '../../../utils/state/my_state.dart';
import '../../../view_model/db_provider.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    Provider.of<DbProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              width: 45,
              "assets/images/icon.png",
              fit: BoxFit.fitWidth,
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
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Consumer<DbProvider>(builder: (context, value, _) {
                if (value.myState == MyState.loading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.blueAccent[100],
                  ));
                } else if (value.favoriteModels.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Image.asset('assets/images/no_data.png'),
                      const Text(
                        'No Favorite Planet Yet!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
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
                  return ListView.builder(
                    itemCount: value.favoriteLength,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 29, 53, 108),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 41, 78, 152)
                                      .withOpacity(0.9),
                                  blurRadius: 50,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animations,
                                            secondaryAnimations) =>
                                        DetailView(
                                      indexPlanet: value.favoriteModels.reversed
                                              .toList()[index]
                                              .idPlanet! -
                                          1,
                                    ),
                                    transitionsBuilder: (context, animations,
                                        secondaryAnimations, childs) {
                                      final tween = Tween(begin: 0.0, end: 1.0);
                                      return FadeTransition(
                                        opacity: animations.drive(tween),
                                        child: childs,
                                      );
                                    },
                                  ),
                                );
                              },
                              leading: SizedBox(
                                width: 90,
                                child: Image.asset(
                                  height: 45,
                                  value.favoriteModels.reversed
                                      .toList()[index]
                                      .planetImg!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              title: Text(
                                value.favoriteModels.reversed
                                    .toList()[index]
                                    .name!
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              textColor: Colors.white,
                              trailing: IconButton(
                                onPressed: () async {
                                  await value.deleteFavorite(
                                    value.favoriteModels.reversed
                                        .toList()[index]
                                        .idPlanet!,
                                  );
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white.withOpacity(0.2),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                        ],
                      );
                    },
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
        ],
      ),
    );
  }
}
