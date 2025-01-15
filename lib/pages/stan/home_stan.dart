import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/pages/stan/profil_stan.dart';

class HomeStan extends StatefulWidget {
  const HomeStan({super.key});

  @override
  State<HomeStan> createState() => _HomeStanState();
}

class _HomeStanState extends State<HomeStan> {
  int _selectedIndex = 0;

  // fungsi untuk navigasi ke halaman
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeStan(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilStan(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeStan(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Stan"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Home Stan"),
            Text("Home Stan"),
            Text("Home Stan"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
        onTap: _onItemTapped,
      ),
    );
  }
}
