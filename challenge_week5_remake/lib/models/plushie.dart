class Plushie {
  final String id;
  final String name;
  final int price;
  final String imageUrl;
  final String role;
  final double rating;
  bool isFavorite;

  Plushie({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.role = 'Official Merchandise',
    this.rating = 5.0,
    this.isFavorite = false,
  });
}