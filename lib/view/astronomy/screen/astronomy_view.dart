import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../utils/state/my_state.dart';
import '../../../view_model/astro_provider.dart';

class AstronomyView extends StatefulWidget {
  const AstronomyView({super.key});

  @override
  State<AstronomyView> createState() => _AstronomyViewState();
}

class _AstronomyViewState extends State<AstronomyView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        final provider = Provider.of<AstroProvider>(context, listen: false);

        provider.fetchAstroDay();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Consumer<AstroProvider>(builder: (context, value, _) {
            if (value.myState == MyState.loading) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.blueAccent[100],
              ));
            } else if (value.myState == MyState.failed) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Oops, Still No Picture At This Moment!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    textAlign: TextAlign.center,
                    'Check Again Later and Make Sure Internet is Connected.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            } else if (value.myState == MyState.success) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      "ASTRONOMY",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "PICTURE OF THE DAY",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      width: MediaQuery.of(context).size.width,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 29, 53, 108),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat('dd MMM yyy').format(
                                      DateTime.parse(value.astroDay!.date!)),
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Image.network(
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            value.astroDay!.url!,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              value.astroDay!.title!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            textAlign: TextAlign.justify,
                            value.astroDay!.explanation!,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 136, 178, 246),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            textAlign: TextAlign.center,
                            value.astroDay!.copyright ?? "",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 25),
                        ],
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
          })
        ],
      ),
    );
  }
}
