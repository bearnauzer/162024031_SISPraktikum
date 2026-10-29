import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobileDeviceFrame(
        child: ProfileScreen(),
      ),
    );
  }
}


class MobileDeviceFrame extends StatelessWidget {
  final Widget child;
  const MobileDeviceFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], 
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Container(
              width: 390, 
              height: 800, 
              decoration: BoxDecoration(
                color: Colors.black, 
                borderRadius: BorderRadius.circular(44),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                border: Border.all(color: Colors.grey[800]!, width: 4), 
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38), 
                child: Column(
                  children: [
                    Container(
                      height: 44,
                      color: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '09:41',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey[900]!, width: 2),
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(Icons.signal_cellular_alt, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Icon(Icons.wifi, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Icon(Icons.battery_std, color: Colors.white, size: 14),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: child,
                      ),
                    ),
                    Container(
                      height: 24,
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.black),
                title: const Text('Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text('Settings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'IlyasK__',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black, size: 28),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('3', 'Posts'),
                        _buildStatColumn('1234', 'Followers'),
                        _buildStatColumn('123', 'Following'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text('Edit Profile'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text('Share Profile'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabIconButton(Icons.grid_on, 0),
                _buildTabIconButton(Icons.bookmark_border, 1),
                _buildTabIconButton(Icons.tag, 2),
              ],
            ),
            const SizedBox(height: 2),

            _buildGalleryContent(),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIconButton(IconData icon, int index) {
    bool isActive = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.black : Colors.transparent, 
                width: 2.0,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.black : Colors.grey, 
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryContent() {
    if (_selectedTabIndex == 0) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[600],
          );
        },
      );
    } else if (_selectedTabIndex == 1) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Center(
          child: Text('Belum ada postingan tersimpan', style: TextStyle(color: Colors.grey)),
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 50.0),
        child: Center(
          child: Text('Belum ada postingan yang ditandai', style: TextStyle(color: Colors.grey)),
        ),
      );
    }
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}