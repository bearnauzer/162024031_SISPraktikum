import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Drink {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  Drink({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Drink drink;
  int quantity;

  CartItem({
    required this.drink,
    required this.quantity,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warung IS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFFCF5FF),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.local_cafe, size: 80, color: Colors.brown[700]),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<CartItem> _cartItems = [];

  final List<Drink> drinkList = [
    Drink(id: '1', name: 'Espresso', price: 15000, imageUrl: 'assets/espresso.jpg'),
    Drink(id: '2', name: 'Americano', price: 18000, imageUrl: 'assets/americano.jpg'),
    Drink(id: '3', name: 'Matcha Latte', price: 25000, imageUrl: 'assets/matcha.jpg'),
    Drink(id: '4', name: 'Chocolate Frappe', price: 28000, imageUrl: 'assets/chocolate.jpg'),
  ];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      int index = _cartItems.indexWhere((item) => item.drink.id == drink.id);
      if (index != -1) {
        _cartItems[index].quantity += quantity;
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        drinkList: drinkList,
        onAddToCart: _addToCart,
      ),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
      ),
    ];

    int totalCartCount = _cartItems.fold(0, (sum, item) => sum + item.quantity);

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: totalCartCount > 0,
              label: Text(totalCartCount.toString()),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList
        .where((drink) =>
            drink.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Warung IS - Menu', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Cari Minuman',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDrinks.length,
              itemBuilder: (context, index) {
                final drink = filteredDrinks[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: Hero(
                      tag: drink.name,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          drink.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    title: Text(
                      drink.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text('Rp ${drink.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetailPage(
                                  drink: drink,
                                  onAddToCart: widget.onAddToCart,
                                ),
                              ),
                            );
                          },
                          child: const Text('Detail'),
                        ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: () {
                            widget.onAddToCart(drink, 1);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${drink.name} ditambahkan!'),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.pink,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Pesan'),
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
    );
  }
}

class DrinkDetailPage extends StatefulWidget {
  final Drink drink;
  final Function(Drink, int) onAddToCart;

  const DrinkDetailPage({
    super.key,
    required this.drink,
    required this.onAddToCart,
  });

  @override
  State<DrinkDetailPage> createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.name, style: const TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    tag: widget.drink.name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.drink.imageUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 64),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.drink.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Harga: Rp ${widget.drink.price}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Jumlah:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  icon: const Icon(Icons.remove_circle, color: Colors.red, size: 32),
                ),
                const SizedBox(width: 16),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon: const Icon(Icons.add_circle, color: Colors.green, size: 32),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onAddToCart(widget.drink, quantity);
                _showSuccessDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[50],
                foregroundColor: Colors.blue[900],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Berhasil Ditambahkan', textAlign: TextAlign.center),
          content: Text(
            'Anda telah menambahkan ${widget.drink.name} ($quantity) ke keranjang.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
  });

  @override
  Widget build(BuildContext context) {
    int totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.drink.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Keranjang Anda', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Keranjang Anda kosong.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item.drink.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                          ),
                        ),
                        title: Text(item.drink.name),
                        subtitle: Text('Harga: Rp ${item.drink.price}  x  ${item.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            onRemoveFromCart(item.drink.id);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rp $totalPrice',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: cartItems.isEmpty
                              ? null
                              : () => _showCheckoutDialog(context, totalPrice),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[50],
                            foregroundColor: Colors.blue[900],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  void _showCheckoutDialog(BuildContext context, int total) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Checkout Berhasil', textAlign: TextAlign.center),
          content: Text(
            'Anda telah berhasil checkout dengan total belanja Rp. $total',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}