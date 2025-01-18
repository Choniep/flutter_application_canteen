import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/pages/customer/home_page.dart';
import 'package:flutter_application_canteen/pages/stan/home_stan_page.dart';
import 'package:flutter_application_canteen/pages/stan/order_page.dart';
import 'package:flutter_application_canteen/pages/stan/profil_stan_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List halaman yang akan ditampilkan
  static final List<Widget> _pages = [
    const HomeStanPage(),
    const OrderPage(),
    const ProfilStanPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen Admint'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.man),
            label: 'Home',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
