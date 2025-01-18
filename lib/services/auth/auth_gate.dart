import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/pages/customer/home_page.dart';
import 'package:flutter_application_canteen/pages/stan/main_screen.dart';
import 'package:flutter_application_canteen/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in
            if (snapshot.hasData) {
              // user signed in
              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(snapshot.data!.uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  String role = userSnapshot.data!['role'];
                  if (role == 'Customer') {
                    return const HomePage();
                  } else if (role == 'Pemilik Stan') {
                    return const MainScreen();
                  }
                  return const LoginOrRegister();
                },
              );
            }

            // user is NOT logged in
            else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
