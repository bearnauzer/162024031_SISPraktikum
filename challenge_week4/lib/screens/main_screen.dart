
import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/cart_item.dart';
import 'home_page.dart';
import 'cart_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<CartItem> _cartItems = [];

  final List<Drink> _drinkList = const [
    Drink(
      id: 'D01',
      name: 'Espresso',
      price: 18000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'D02',
      name: 'Americano',
      price: 20000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'D03',
      name: 'Matcha Latte',
      price: 25000,
      imageUrl: 'assets/cafe.png',
    ),
    Drink(
      id: 'D04',
      name: 'Chocolate Frappe',
      price: 27000,
      imageUrl: 'assets/cafe.png',
    ),
  ];

  void _addToCart(Drink drink, int quantity) {
    if (quantity < 1) return;

    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (index != -1) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(
          CartItem(
            drink: drink,
            quantity: quantity,
          ),
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${drink.name} ditambahkan ke keranjang'),
      ),
    );
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere(
        (item) => item.drink.id == drinkId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(
            drinkList: _drinkList,
            onAddToCart: _addToCart,
          ),
          CartPage(
            cartItems: _cartItems,
            onRemoveFromCart: _removeFromCart,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
