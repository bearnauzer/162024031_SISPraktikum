import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/plushie.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'add_product.dart';
import 'edit_product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> { 
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];
  
  final List<Plushie> _plushieList = [
    Plushie(id: 'p1', name: 'Bang', price: 350000, imageUrl: 'assets/bang.jpg', role: 'Leader & Leader Guitar', rating: 4.9, isFavorite: true),
    Plushie(id: 'p2', name: 'Ke', price: 350000, imageUrl: 'assets/ke.jpg', role: 'Main Vocal & Rapper', rating: 5.0, isFavorite: false),
    Plushie(id: 'p3', name: 'Pil', price: 350000, imageUrl: 'assets/pil.jpg', role: 'Synthesizer & Vocal', rating: 4.8, isFavorite: true),
    Plushie(id: 'p4', name: 'Don', price: 350000, imageUrl: 'assets/don.jpg', role: 'Drums & Maknae', rating: 4.9, isFavorite: false),
    Plushie(id: 'p5', name: 'Jje', price: 350000, imageUrl: 'assets/jje.jpg', role: 'Rhythm Guitar & Vocal', rating: 5.0, isFavorite: true),
  ];

  void _addProduct(Plushie newPlushie) {
    setState(() {
      _plushieList.add(newPlushie);
    });
  }

  void _updateProduct(Plushie updatedPlushie) {
    setState(() {
      final index = _plushieList.indexWhere((p) => p.id == updatedPlushie.id);
      if (index != -1) {
        _plushieList[index] = updatedPlushie;
      }
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _plushieList.removeWhere((p) => p.id == id);
    });
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(onSave: _addProduct),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, Plushie plushie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(
          existingPlushie: plushie,
          onSave: _updateProduct,
        ),
      ),
    );
  }

  void _addToCart(Plushie plushie, int quantity) {
    setState(() {
      final existingIndex = _cartItems.indexWhere((item) => item.plushie.id == plushie.id);
      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity += quantity;
      } else {
        _cartItems.add(CartItem(plushie: plushie, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String id) {
    setState(() {
      _cartItems.removeWhere((item) => item.plushie.id == id);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  List<Widget> _buildPages() {
    return [
      HomePage(
        plushieList: _plushieList,
        onAddToCart: _addToCart,
        onAdd: () => _navigateToAddPage(context),
        onEdit: (Plushie p) => _navigateToEditPage(context, p),
        onDelete: _deleteProduct,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onClearCart: _clearCart,
      ),
    ];
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
              extendBody: true,
              body: _buildPages()[_selectedIndex],
              bottomNavigationBar: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white.withOpacity(0.75),
                      selectedItemColor: const Color(0xFFFF6B8B),
                      unselectedItemColor: Colors.grey[500],
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      elevation: 0,
                      items: [
                        const BottomNavigationBarItem(
                          icon: Icon(Icons.grid_view_rounded, size: 26),
                          activeIcon: Icon(Icons.grid_view_rounded, size: 30),
                          label: 'Shop',
                        ),
                        BottomNavigationBarItem(
                          icon: Badge(
                            isLabelVisible: _cartItems.isNotEmpty,
                            label: Text(_cartItems.length.toString()),
                            backgroundColor: const Color(0xFFFF6B8B),
                            child: const Icon(Icons.shopping_bag_outlined, size: 26),
                          ),
                          activeIcon: const Icon(Icons.shopping_bag_rounded, size: 30),
                          label: 'Cart',
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      onTap: (index) => setState(() => _selectedIndex = index),
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