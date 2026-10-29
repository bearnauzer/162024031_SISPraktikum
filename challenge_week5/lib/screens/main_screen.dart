import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/drink.dart';
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
  final List<Drink> _drinkList = [
    Drink(
      id: 'd1',
      name: 'Espresso',
      price: 18000,
      imageUrl: 'assets/espresso.jpg',
    ),
    Drink(
      id: 'd2',
      name: 'Americano',
      price: 20000,
      imageUrl: 'assets/americano.jpg',
    ),
    Drink(
      id: 'd3',
      name: 'Matcha Latte',
      price: 25000,
      imageUrl: 'assets/matcha_latte.jpg',
    ),
    Drink(
      id: 'd4',
      name: 'Chocolate Frappe',
      price: 28000,
      imageUrl: 'assets/chocolate_frappe.jpg',
    ),
  ];

  void _addProduct(Drink newDrink) {
    setState(() {
      _drinkList.add(newDrink);
    });
  }

  void _updateProduct(Drink updatedDrink) {
    setState(() {
      final index = _drinkList.indexWhere(
        (drink) => drink.id == updatedDrink.id,
      );
      if (index != -1) {
        _drinkList[index] = updatedDrink;
      }
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _drinkList.removeWhere((drink) => drink.id == id);
    });
  }

  void _navigateToAddPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(
          onSave: (Drink newDrink) {
            _addProduct(newDrink);
          },
        ),
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, Drink drinkToEdit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(
          existingDrink: drinkToEdit,
          onSave: (Drink updatedDrink) {
            _updateProduct(updatedDrink);
          },
        ),
      ),
    );
  }

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      final existingIndex = _cartItems.indexWhere(
        (item) => item.drink.id == drink.id,
      );

      if (existingIndex != -1) {
        _cartItems[existingIndex].quantity += quantity;
      } else {
        _cartItems.add(CartItem(drink: drink, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere((item) => item.drink.id == drinkId);
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
        drinkList: _drinkList,
        onAddToCart: _addToCart,
        onAdd: () {
          _navigateToAddPage(context);
        },
        onEdit: (Drink drink) {
          _navigateToEditPage(context, drink);
        },
        onDelete: _deleteProduct,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onClearCart: _clearCart,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPages();

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.local_cafe), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(_cartItems.length.toString()),
              isLabelVisible: _cartItems.isNotEmpty,
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Keranjang',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}