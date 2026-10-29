import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Key untuk validasi Form[cite: 1]
  final _formKey = GlobalKey<FormState>();
  
  // Controller untuk input pengguna
  final _namaController = TextEditingController();
  final _mejaController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _mejaController.dispose();
    super.dispose();
  }

  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  int get totalPrice {
    return widget.cartItems.fold(
      0,
      (total, item) => total + item.drink.price * item.quantity,
    );
  }

  void checkout(BuildContext context) {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Keranjang masih kosong'),
        ),
      );
      return;
    }

    // Hanya proses checkout jika validasi form berhasil[cite: 1]
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Checkout Berhasil'),
            content: Text(
              'Terima kasih telah memesan di Warung IS.\n'
              'Nama: ${_namaController.text}\n'
              'Meja: ${_mejaController.text}\n'
              'Total pembayaran: ${formatRupiah(totalPrice)}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Keranjang masih kosong',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];

                return Card(
                  child: ListTile(
                    leading: Image.asset(
                      item.drink.imageUrl,
                      width: 45,
                      height: 45,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.local_cafe),
                    ),
                    title: Text(item.drink.name),
                    subtitle: Text(
                      '${item.quantity} x '
                      '${formatRupiah(item.drink.price)}\n'
                      'Subtotal: ${formatRupiah(item.drink.price * item.quantity)}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        widget.onRemoveFromCart(item.drink.id);
                      },
                    ),
                  ),
                );
              },
            ),
      // Menampilkan Form di bagian bawah jika keranjang tidak kosong[cite: 1]
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Form Nama Pemesan[cite: 1]
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Pemesan',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nama Pemesan tidak boleh kosong'; //[cite: 1]
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      
                      // Form Nomor Meja[cite: 1]
                      TextFormField(
                        controller: _mejaController,
                        decoration: const InputDecoration(
                          labelText: 'Nomor Meja',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nomor Meja harus berupa angka'; //[cite: 1]
                          }
                          
                          final int? nomorMeja = int.tryParse(value);
                          if (nomorMeja == null) {
                            return 'Nomor Meja harus berupa angka'; //[cite: 1]
                          }
                          
                          if (nomorMeja < 1 || nomorMeja > 20) {
                            return 'Nomor Meja harus antara 1-20'; //[cite: 1]
                          }
                          
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            formatRupiah(totalPrice),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => checkout(context),
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}