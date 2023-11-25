import 'package:flutter/material.dart';
import 'package:our_space/view/astronomy/screen/astronomy_view.dart';
import 'package:our_space/view/favorite/screen/favorite_view.dart';
import 'package:our_space/view/home/screen/about_view.dart';
import 'package:our_space/view/image_search_screen.dart';
import '../../feedback/screen/feedback_view.dart';
import '../widget/card_widget.dart';
import '../widget/list_drawer.dart';
import '../../planet/screen/planets_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 41, 78, 152).withOpacity(0.5),
                blurRadius: 150,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/icon.png",
                width: 200,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const PickedDrawer(
                title: 'Home',
                icon: Icons.home,
              ),
              const SizedBox(height: 10),
              const ListDrawer(
                title: 'Favorite Planet',
                icon: Icons.favorite_rounded,
                page: FavoriteView(),
              ),
              const SizedBox(height: 10),
              const ListDrawer(
                title: 'Find Galaxy',
                icon: Icons.search,
                page: NasaImagesPage(),
              ),
              const SizedBox(height: 10),
              const ListDrawer(
                title: 'Feedback Form',
                icon: Icons.message_rounded,
                page: FeedbackView(),
              ),
              const SizedBox(height: 10),
              const ListDrawer(
                title: 'About Me',
                icon: Icons.account_box,
                page: NewWidget(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              const Text(
                "Made By Retno",
                style: TextStyle(color: Color.fromARGB(255, 83, 116, 182)),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Hero(
              tag: "LogoTag",
              child: Image.asset(
                "assets/images/icon.png",
                width: 40,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              "OUR SPACE",
              style: TextStyle(
                  fontFamily: 'BrunoAce',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  SizedBox(height: 10),

                  // Card for planets page
                  CardWidget(
                    imageCard: "assets/images/card_planet.png",
                    pages: PlanetsView(),
                    title1: 'EXPLORE',
                    title2: 'SOLAR',
                    title3: 'SYSTEM',
                  ),

                  // Card for astronomy picture page
                  CardWidget(
                    imageCard: "assets/images/card_astronomy.jpg",
                    pages: AstronomyView(),
                    title1: 'NASA',
                    title2: 'ASTRONOMY',
                    title3: 'PICTURE OF THE DAY',
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AboutView();
  }
}
