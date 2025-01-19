import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_food_tile.dart';
import 'package:flutter_application_canteen/models/food.dart';
import 'package:flutter_application_canteen/models/restaurant.dart';
import 'package:flutter_application_canteen/pages/customer/food_page.dart';
import 'package:provider/provider.dart';

class HomeStanPage extends StatefulWidget {
  const HomeStanPage({super.key});

  @override
  State<HomeStanPage> createState() => _HomeStanPageState();
}

class _HomeStanPageState extends State<HomeStanPage> {
  // menampilkan semua menu yang ada
  List<Widget> getAllFoodItems(List<Food> fullMenu) {
    return [
      ListView.builder(
        itemCount: fullMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final food = fullMenu[index];
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodPage(food: food),
              ),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                "Kantik Pak Lebah",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
