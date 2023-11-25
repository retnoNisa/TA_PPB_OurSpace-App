import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  final Map<String, dynamic> image;

  const ImageDetailPage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: SingleChildScrollView( // Wrap with SingleChildScrollView
              child: Column(
                children: [
                  // App Bar
                  AppBar(
                    title: Text(image['title'], style: TextStyle(color: Colors.white)),
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
                  const SizedBox(height: 16),
                  // Image
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 32, // 16 padding on each side
                    child: Image.network(image['imageUrl']),
                  ),
                  const SizedBox(height: 16),
                  // Description
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      image['description'],
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10), // Add some space between description and search
                  // Your search widget goes here
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      // Your search field implementation
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
