import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DiscountSetPage extends StatelessWidget {
  const DiscountSetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Discount"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Iconsax.add),
          ),
        ],
      ),
      body: Center(
        child: Text("discount"),
      ),
    );
  }
}
