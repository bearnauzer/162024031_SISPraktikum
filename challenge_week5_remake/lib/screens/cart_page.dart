import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final void Function() onClearCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    required this.onClearCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
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
      (total, item) => total + item.plushie.price * item.quantity,
    );
  }

  void checkout(BuildContext context) {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang masih kosong')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Checkout Berhasil 🎉'),
            content: Text(
              'Terima kasih telah memesan di Denimalz Store!\n\n'
              'Nama: ${_namaController.text}\n'
              'Alamat: ${_alamatController.text}\n'
              'Total: ${formatRupiah(totalPrice)}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  widget.onClearCart();
                  _namaController.clear();
                  _alamatController.clear();
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK', style: TextStyle(color: Color(0xFFFF8DA1))),
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
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        title: const Text('Keranjang Belanja', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFB6C1),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('Keranjang masih kosong', style: TextStyle(fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Image.asset(
                      item.plushie.imageUrl,
                      width: 45,
                      height: 45,
                      errorBuilder: (_, __, ___) => const Icon(Icons.pets, color: Colors.pinkAccent),
                    ),
                    title: Text(item.plushie.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '${item.quantity} x ${formatRupiah(item.plushie.price)}\n'
                      'Subtotal: ${formatRupiah(item.plushie.price * item.quantity)}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.onRemoveFromCart(item.plushie.id);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 16, right: 16, top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Nama Penerima',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.person, color: Color(0xFFFF8DA1)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Nama tidak boleh kosong';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _alamatController,
                        decoration: InputDecoration(
                          labelText: 'Alamat Pengiriman',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          prefixIcon: const Icon(Icons.location_on, color: Color(0xFFFF8DA1)),
                        ),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Alamat Pengiriman tidak boleh kosong';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Pembayaran', style: TextStyle(fontSize: 16)),
                          Text(
                            formatRupiah(totalPrice),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFF8DA1)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB6C1),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () => checkout(context),
                          child: const Text('Checkout', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
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