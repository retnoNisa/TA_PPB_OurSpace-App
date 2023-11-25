import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
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
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        actions: [
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                "assets/images/icon.png",
                width: 45,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circular profile image
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Text 'let to know me'
                  Text(
                    'Bonjour!!!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 16),

                  // Text 'Welcome to Our Space App!'
                  Text(
                    'Welcome to Our Space App! This app allows you to explore the wonders of our solar system and beyond. It is created by Retno with a passion for space exploration.',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center, // Center the text
                  ),
                  SizedBox(height: 16),

                  // Buttons
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _launchURL("https://github.com/retnoNisa");
                        },
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 41, 78, 152)
                                          .withOpacity(0.6)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text('GitHub', style: TextStyle(color: Color.fromARGB(255, 220, 87, 213)))),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          _launchURL("https://www.linkedin.com/in/retno-nisa-ul-kamila/");
                        },
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 41, 78, 152)
                                          .withOpacity(0.6)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text('LinkedIn', style: TextStyle(color: Color.fromARGB(255, 220, 87, 213)))),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          _launchURL("https://www.instagram.com/nisa_kmila/");
                        },
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 41, 78, 152)
                                          .withOpacity(0.6)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text('Instagram', style: TextStyle(color: Color.fromARGB(255, 220, 87, 213)))),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          _launchURL("http://wa.me/6281553177931");
                        },
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 41, 78, 152)
                                          .withOpacity(0.6)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Center(child: Text('WhatsApp', style: TextStyle(color: Color.fromARGB(255, 220, 87, 213)))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to launch URL
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
