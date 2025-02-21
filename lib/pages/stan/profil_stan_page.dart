import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/stan/profil_menu_button.dart';
import 'package:flutter_application_canteen/pages/stan/add_product_page.dart';
import 'package:flutter_application_canteen/pages/stan/discount_set_page.dart';
import 'package:flutter_application_canteen/pages/stan/revenue_page.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';
import 'package:iconsax/iconsax.dart';

class ProfilStan extends StatelessWidget {
  const ProfilStan({super.key});

  void logout() {
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    ClipOval(
                      child: Image(
                        image: AssetImage(
                          'lib/assets/images/profil/hindia.jpg',
                        ),
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kantin",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Baskara Putra",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ProfilMenuButton(
                  title: 'Ubah Profil',
                  icon: Iconsax.message_edit,
                  onTap: () {},
                ),
                ProfilMenuButton(
                  title: 'Manage Diskon',
                  icon: Iconsax.receipt_discount,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiscountSetPage(),
                      ),
                    );
                  },
                ),
                ProfilMenuButton(
                  title: 'Manage Menu',
                  icon: Iconsax.add_square,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductPage(
                          standId: '01',
                        ),
                      ),
                    );
                  },
                ),
                ProfilMenuButton(
                  title: 'Log Out',
                  icon: Iconsax.logout,
                  onTap: () {
                    logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
