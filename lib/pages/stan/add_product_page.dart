import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_button.dart';
import 'package:flutter_application_canteen/components/stan/add_menu_dialog.dart';
import 'package:flutter_application_canteen/components/stan/menu_list_tile.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';
import 'package:flutter_application_canteen/services/canteen/menu_service.dart';
import 'package:iconsax/iconsax.dart';

class AddProductPage extends StatelessWidget {
  final String standId;

  const AddProductPage({super.key, required this.standId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Menu"),
        actions: [
          IconButton(
            onPressed: () async {
              // Membuka dialog AddMenuDialog
              final result = await showDialog(
                context: context,
                builder: (context) => AddMenuDialog(stanId: standId),
              );
            },
            icon: Icon(
              Iconsax.add,
              size: 35,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MenuListTile(),
          ],
        ),
      ),
    );
  }
}
