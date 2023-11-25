import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String imageCard;
  final Widget pages;
  final String title1;
  final String title2;
  final String title3;

  const CardWidget({
    super.key,
    required this.imageCard,
    required this.pages,
    required this.title1,
    required this.title2,
    required this.title3,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 50,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            image: AssetImage(imageCard),
            fit: BoxFit.cover,
          ),
        ),
        width: MediaQuery.of(context).size.width - 2 * 30,
        height: MediaQuery.of(context).size.height - 2 * 250,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Colors.black.withOpacity(0.4),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animations, secondaryAnimations) =>
                        pages,
                    transitionsBuilder:
                        (context, animations, secondaryAnimations, childs) {
                      final tween = Tween(begin: 0.0, end: 1.0);
                      return FadeTransition(
                        opacity: animations.drive(tween),
                        child: childs,
                      );
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      title2,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      title3,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
