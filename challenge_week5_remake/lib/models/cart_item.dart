import 'plushie.dart';

class CartItem {
  final Plushie plushie;
  int quantity;

  CartItem({
    required this.plushie,
    this.quantity = 1,
  });
}