import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                // food image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "lib/assets/images/drinks/cappucino_coffee.jpeg",
                    height: 100,
                    width: 100,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    Text("Ikan mujaer"),

                    // description
                    Text("Makanan enak jir"),

                    // food price
                    Text('Rp 10.000'),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
