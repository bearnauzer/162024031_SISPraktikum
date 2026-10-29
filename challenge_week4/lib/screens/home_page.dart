import 'package:flutter/material.dart';
import '../models/drink.dart';
import 'drink_detail_page.dart';
import 'add_product.dart'; 

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';

  String formatRupiah(int price) {
    return 'Rp${price.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList
        .where(
          (drink) => drink.name
              .toLowerCase()
              .contains(searchText.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Warung IS'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Cari Minuman',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Daftar Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredDrinks.isEmpty
                ? const Center(
                    child: Text('Minuman tidak ditemukan'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset(
                                drink.imageUrl,
                                width: 60,
                                height: 60,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(
                                  Icons.local_cafe,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      drink.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(formatRupiah(drink.price)),
                                    const SizedBox(height: 5),
                                    Wrap(
                                      spacing: 5,
                                      children: [
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DrinkDetailPage(
                                                  drink: drink,
                                                  onAddToCart:
                                                      widget.onAddToCart,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Detail'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            widget.onAddToCart(
                                              drink,
                                              1,
                                            );
                                          },
                                          child: const Text('Pesan'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFFEADDFF), 
        child: const Icon(Icons.add, color: Color(0xFF21005D)),
      ),
    );
  }
}