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
  // Return a single widget for all foods
  Widget getAllFoods(List<Food> fullMenu) {
    return ListView.builder(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
        SliverAppBar(
          expandedHeight: 120,
          collapsedHeight: 90,
          title: Text("Sikma"),
        )
      ],
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Consumer<Restaurant>(
          builder: (context, restaurant, child) => getAllFoods(restaurant.menu),
        ),
      ),
    );
  }
}
