import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_button.dart';
import 'package:flutter_application_canteen/components/my_textfield.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // dropdown role options
  final List<String> roles = ['Customer', 'Pemilik Stan'];
  String? selectedRole = 'Customer'; // to store selected role

  // register method
  void register() async {
    // fill out authentication here

    // get auth service
    final _authService = AuthService();

    // check if password match && role is selected-> create user
    if (passwordController.text == confirmPasswordController.text) {
      if (selectedRole != null) {
        // try creating user
        try {
          await _authService.signUpWithEmailPassword(emailController.text,
              passwordController.text, usernameController.text, selectedRole);
        }

        // display any errors
        catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                e.toString(),
              ),
            ),
          );
        }
      } else {
        // show error if no role selected
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Please select role"),
          ),
        );
      }
    }

    // if password don't match -> show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(
              height: 25,
            ),

            // message, app slogan
            Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //email textfield
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            //username textfield
            MyTextfield(
              controller: usernameController,
              hintText: "username",
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            // password textfield
            MyTextfield(
              controller: passwordController,
              hintText: "password",
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            // confirm password textfield
            MyTextfield(
              controller: confirmPasswordController,
              hintText: "Confirm password",
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            // role dropdown
            DropdownButton<String>(
              value: selectedRole,
              hint: Text("Select your role"),
              isExpanded: false,
              items: roles.map<DropdownMenuItem<String>>((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),

            // sign up button
            MyButton(
              text: "Sign Up",
              onTap: () {
                register();
              },
            ),

            const SizedBox(
              height: 10,
            ),

            // already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
