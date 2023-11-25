import 'package:flutter/material.dart';
import 'package:our_space/model/images_api.dart';
import 'image_detail_screen.dart';

class NasaImagesPage extends StatefulWidget {
  const NasaImagesPage({Key? key}) : super(key: key);

  @override
  _NasaImagesPageState createState() => _NasaImagesPageState();
}

class _NasaImagesPageState extends State<NasaImagesPage> {
  final NasaApi nasaApi = NasaApi();
  List<Map<String, dynamic>> nasaImages = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;

  Future<void> fetchNasaImages({String query = 'galaxy'}) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await nasaApi.fetchNasaImages(query: query);
      final jsonData = response.data;
      final items = jsonData['collection']['items'] as List<dynamic>;

      setState(() {
        nasaImages = items.map((item) {
          final data = item['data'][0];
          final links = item['links'][0];
          return {
            'title': data['title'],
            'description': data['description'],
            'imageUrl': links['href'],
          };
        }).toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNasaImages();
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
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20), // Adjustment for search field
              Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 25.0, left: 25.0), // Adding padding on top, right, and left
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white), // Set the text color
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white), // Set the hint text color
                    suffixIcon: IconButton(
                      onPressed: () {
                        fetchNasaImages(query: _searchController.text);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  ),
                ),
              ),
              if (isLoading)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: nasaImages.length,
                    itemBuilder: (context, index) {
                      final image = nasaImages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailPage(image: image),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Card(
                            color: const Color.fromARGB(255, 0, 36, 57),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      image['imageUrl'],
                                      width: 300,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    image['title'],
                                    style: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NasaImagesPage(),
  ));
}
