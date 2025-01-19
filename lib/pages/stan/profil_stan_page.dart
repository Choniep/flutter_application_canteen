import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/stan/profil_menu_button.dart';

class ProfilStanPage extends StatelessWidget {
  const ProfilStanPage({super.key});

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
                          'lib/images/burgers/beef_burger.webp',
                        ),
                        width: 130,
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
                          "Pak Lebah",
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
                  title: 'Ubah Nama',
                  icon: Icons.home,
                  onTap: () {},
                ),
                ProfilMenuButton(
                  title: 'Atur Diskon',
                  icon: Icons.home,
                  onTap: () {},
                ),
                ProfilMenuButton(
                  title: 'Pemasukan & History',
                  icon: Icons.home,
                  onTap: () {},
                ),
                ProfilMenuButton(
                  title: 'Tambah Menu',
                  icon: Icons.home,
                  onTap: () {},
                ),
                ProfilMenuButton(
                  title: 'Log Out',
                  icon: Icons.home,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
