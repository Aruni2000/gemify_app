// shop/gem_modal.dart
class Gem {
  final String name;
  final String price;
  final String description;
  final String image;
  final double weight; // carat
  final String clarity;
  final String size; // dimensions
  final String color;
  final String shapeAndCut;
  final String origin;
  final String heated;
  final String certificate;

  Gem({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.weight,
    required this.clarity,
    required this.size,
    required this.color,
    required this.shapeAndCut,
    required this.origin,
    required this.heated,
    required this.certificate,
  });
}
