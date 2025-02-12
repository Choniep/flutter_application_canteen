import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_button.dart';
import 'package:flutter_application_canteen/components/stan/add_menu_dialog.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';
import 'package:flutter_application_canteen/services/canteen/menu_service.dart';

class AddProductPage extends StatelessWidget {
  final String standId;

  const AddProductPage({super.key, required this.standId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyButton(
                text: "Add Product",
                onTap: () async {
                  // Membuka dialog AddMenuDialog
                  final result = await showDialog(
                    context: context,
                    builder: (context) => AddMenuDialog(
                      stanId: standId,
                    ),
                  );

                  // Handle hasil dari dialog (misalnya, refresh data)
                  if (result == true) {
                    // Lakukan sesuatu setelah menu berhasil ditambahkan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Menu added successfully!')),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
