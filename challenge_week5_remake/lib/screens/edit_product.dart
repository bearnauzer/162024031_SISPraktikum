import 'package:flutter/material.dart';
import '../models/plushie.dart';

class EditProductPage extends StatefulWidget {
  final Function(Plushie) onSave;
  final Plushie existingPlushie;

  const EditProductPage({
    Key? key,
    required this.onSave,
    required this.existingPlushie,
  }) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.existingPlushie.name;
    _priceController.text = widget.existingPlushie.price.toString();
    _imageUrlController.text = widget.existingPlushie.imageUrl;
    _roleController.text = widget.existingPlushie.role;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final price = int.parse(_priceController.text);
      final imageUrl = _imageUrlController.text;
      final role = _roleController.text;

      final updatedPlushie = Plushie(
        id: widget.existingPlushie.id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        role: role,
        rating: widget.existingPlushie.rating,
        isFavorite: widget.existingPlushie.isFavorite,
      );

      widget.onSave(updatedPlushie);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produk berhasil diperbarui!'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pop();
    }
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
              appBar: AppBar(
                title: const Text('Edit Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: const Color(0xFFFFB6C1),
                foregroundColor: Colors.white,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nama Karakter', border: OutlineInputBorder(), prefixIcon: Icon(Icons.pets, color: Color(0xFFFF8DA1))),
                          validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong.' : null,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _roleController,
                          decoration: const InputDecoration(labelText: 'Role / Posisi', border: OutlineInputBorder(), prefixIcon: Icon(Icons.music_note, color: Color(0xFFFF8DA1))),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _priceController,
                          decoration: const InputDecoration(labelText: 'Harga', prefixText: 'Rp ', border: OutlineInputBorder(), prefixIcon: Icon(Icons.price_change, color: Color(0xFFFF8DA1))),
                          keyboardType: TextInputType.number,
                          validator: (value) => (value == null || value.isEmpty) ? 'Harga tidak boleh kosong.' : null,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _imageUrlController,
                          decoration: const InputDecoration(labelText: 'Path Gambar', hintText: 'Contoh: assets/bang.jpg', border: OutlineInputBorder(), prefixIcon: Icon(Icons.image, color: Color(0xFFFF8DA1))),
                          validator: (value) => (value == null || value.isEmpty) ? 'Path gambar tidak boleh kosong.' : null,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8DA1), padding: const EdgeInsets.symmetric(vertical: 16.0)),
                          child: const Text('Simpan Perubahan', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ],
                    ),
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