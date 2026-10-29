
import 'package:flutter/material.dart';
import '../models/drink.dart';

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() =>
      _DrinkDetailPageState();
}

class _DrinkDetailPageState
    extends State<DrinkDetailPage> {
  int _quantity = 1;

  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final drink = widget.drink;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Minuman'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              drink.imageUrl,
              width: 150,
              height: 150,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.local_cafe,
                size: 120,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              drink.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formatRupiah(drink.price),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text('Minuman pilihan Warung IS'),
            const Spacer(),
            const Text(
              'Jumlah Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _quantity > 1
                      ? () {
                          setState(() {
                            _quantity--;
                          });
                        }
                      : null,
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  iconSize: 35,
                ),
                Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  iconSize: 35,
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  widget.onAddToCart(
                    widget.drink,
                    _quantity,
                  );
                  Navigator.pop(context);
                },
                child: const Text('Tambah ke Keranjang'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
