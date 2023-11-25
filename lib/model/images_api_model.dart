class ImageApi {
  final Collection collection;

  ImageApi({required this.collection});

  factory ImageApi.fromJson(Map<String, dynamic> json) {
    return ImageApi(
      collection: Collection.fromJson(json['collection']),
    );
  }
}

class Collection {
  final String version;
  final String href;
  final List<Item> items;
  final Metadata metadata;

  Collection({
    required this.version,
    required this.href,
    required this.items,
    required this.metadata,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      version: json['version'],
      href: json['href'],
      items:
          (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
      metadata: Metadata.fromJson(json['metadata']),
    );
  }
}

class Item {
  final String href;
  final List<Datum> data;
  final List<Link> links; // Add links list here

  Item({
    required this.href,
    required this.data,
    required this.links, // Initialize the links list
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      href: json['href'],
      data:
          (json['data'] as List).map((datum) => Datum.fromJson(datum)).toList(),
      links: (json['links'] as List)
          .map((link) => Link.fromJson(link))
          .toList(), // Parse links list
    );
  }
}

// class Item {
//   final String href;
//   final List<Datum> data;

//   Item({required this.href, required this.data});

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       href: json['href'],
//       data:
//           (json['data'] as List).map((datum) => Datum.fromJson(datum)).toList(),
//     );
//   }
// }

class Datum {
  final String description;
  final String title;

  Datum({required this.description, required this.title});

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      description: json['description'],
      title: json['title'],
    );
  }
}

class Metadata {
  final int totalHits;

  Metadata({required this.totalHits});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      totalHits: json['total_hits'],
    );
  }
}

class Link {
  final String href;
  final String rel;
  final String render;

  Link({required this.href, required this.rel, required this.render});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
      rel: json['rel'],
      render: json['render'],
    );
  }
}
