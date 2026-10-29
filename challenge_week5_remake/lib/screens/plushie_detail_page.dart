import 'package:flutter/material.dart';
import '../models/plushie.dart';

class PlushieDetailPage extends StatefulWidget {
  final Plushie plushie;
  final Function(Plushie, int) onAddToCart;

  const PlushieDetailPage({
    Key? key,
    required this.plushie,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  _PlushieDetailPageState createState() => _PlushieDetailPageState();
}

class _PlushieDetailPageState extends State<PlushieDetailPage> {
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _showSuccessDialog(BuildContext context, String itemName, int quantity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Berhasil Ditambahkan 🧸', style: TextStyle(color: Color(0xFFFF8DA1))),
          content: Text('Kamu telah menambahkan $itemName ($quantity) ke keranjang.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Color(0xFFFF8DA1))),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D253A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 880),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF8DA1).withOpacity(0.3),
                blurRadius: 35,
                spreadRadius: 8,
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: Scaffold(
              backgroundColor: const Color(0xFFFFF0F5),
              appBar: AppBar(
                title: Text(widget.plushie.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: const Color(0xFFFFB6C1),
                foregroundColor: Colors.white,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlushieInfoCard(plushie: widget.plushie),
                      const SizedBox(height: 20),
                      const Text('Jumlah:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: _decrementQuantity,
                            iconSize: 40,
                            color: Colors.red[300],
                          ),
                          Text(
                            '$_quantity',
                            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle),
                            onPressed: _incrementQuantity,
                            iconSize: 40,
                            color: const Color(0xFFFF8DA1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8DA1),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('Tambah ke Keranjang', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          widget.onAddToCart(widget.plushie, _quantity);
                          _showSuccessDialog(context, widget.plushie.name, _quantity);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlushieInfoCard extends StatelessWidget {
  final Plushie plushie;

  const PlushieInfoCard({Key? key, required this.plushie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Hero(
              tag: plushie.id,
              child: Image.asset(
                plushie.imageUrl,
                height: 180,
                width: 180,
                fit: BoxFit.contain,
                errorBuilder: (ctx, err, stack) => Icon(Icons.pets, size: 80, color: Colors.pink[200]),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              plushie.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              plushie.role,
              style: const TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              'Harga: Rp ${plushie.price}',
              style: const TextStyle(
                fontSize: 22,
                color: Color(0xFFFF8DA1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}