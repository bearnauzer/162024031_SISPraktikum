import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/plushie.dart';
import 'plushie_detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Plushie> plushieList;
  final Function(Plushie, int) onAddToCart;
  final void Function() onAdd;
  final void Function(Plushie) onEdit;
  final void Function(String) onDelete;

  const HomePage({
    Key? key,
    required this.plushieList,
    required this.onAddToCart,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = '';
  String selectedFilter = 'All';

  final List<String> categories = ['All', 'Leader', 'Vocal', 'Drums', 'Favorite'];

  void _showQuickAddDialog(String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.white),
            const SizedBox(width: 10),
            Text('$itemName berhasil diadopsi! ✨'),
          ],
        ),
        backgroundColor: const Color(0xFFFF6B8B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.plushieList.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(searchText.toLowerCase());
      if (selectedFilter == 'All') return matchesSearch;
      if (selectedFilter == 'Favorite') return matchesSearch && p.isFavorite;
      return matchesSearch && p.role.toLowerCase().contains(selectedFilter.toLowerCase());
    }).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5F7), Color(0xFFFFE3EC), Color(0xFFE8E0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Denimalz World 🐾',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFFFF5277)),
                            ),
                            Text(
                              'Temukan teman plushie MyDay kamu!',
                              style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: widget.onAdd,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.pink.withOpacity(0.2), blurRadius: 10),
                              ],
                            ),
                            child: const Icon(Icons.add, color: Color(0xFFFF5277), size: 24),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.8)),
                          ),
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: 'Cari Denimalz favoritmu...',
                              hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
                              border: InputBorder.none,
                              icon: Icon(Icons.search_rounded, color: Color(0xFFFF6B8B)),
                            ),
                            onChanged: (val) => setState(() => searchText = val),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    final isSelected = selectedFilter == cat;
                    return GestureDetector(
                      onTap: () => setState(() => selectedFilter = cat),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFF6B8B) : Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [BoxShadow(color: const Color(0xFFFF6B8B).withOpacity(0.4), blurRadius: 8)]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            cat,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final plushie = filteredList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlushieDetailPage(
                              plushie: plushie,
                              onAddToCart: widget.onAddToCart,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.55),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.pink.withOpacity(0.08),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFE3EC),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star_rounded, color: Colors.orangeAccent, size: 14),
                                            const SizedBox(width: 3),
                                            Text(
                                              plushie.rating.toString(),
                                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => widget.onEdit(plushie),
                                            child: const Icon(Icons.edit_rounded, color: Colors.blueAccent, size: 18),
                                          ),
                                          const SizedBox(width: 6),
                                          GestureDetector(
                                            onTap: () => widget.onDelete(plushie.id),
                                            child: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 18),
                                          ),
                                          const SizedBox(width: 6),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                plushie.isFavorite = !plushie.isFavorite;
                                              });
                                            },
                                            child: Icon(
                                              plushie.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                              color: plushie.isFavorite ? const Color(0xFFFF5277) : Colors.grey,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Hero(
                                        tag: plushie.id,
                                        child: Image.asset(
                                          plushie.imageUrl,
                                          fit: BoxFit.contain,
                                          errorBuilder: (ctx, err, stack) => Icon(Icons.pets, size: 60, color: Colors.pink[200]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    plushie.name,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black87),
                                  ),
                                  Text(
                                    plushie.role,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rp${(plushie.price / 1000).toStringAsFixed(0)}k',
                                        style: const TextStyle(fontSize: 15, color: Color(0xFFFF5277), fontWeight: FontWeight.w900),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          widget.onAddToCart(plushie, 1);
                                          _showQuickAddDialog(plushie.name);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFF6B8B),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: const Icon(Icons.add_shopping_cart_rounded, color: Colors.white, size: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}