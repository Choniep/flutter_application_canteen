import 'package:flutter/material.dart';

class ProfilStanPage extends StatelessWidget {
  const ProfilStanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
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
                SizedBox(
                  height: 20,
                ),
                Text("Sikma"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
