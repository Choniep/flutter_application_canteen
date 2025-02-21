import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_button.dart';
import 'package:flutter_application_canteen/components/my_textfield.dart';
import 'package:flutter_application_canteen/pages/create_profil_screen.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  String _role = 'siswa';

  // register method
  void register(context) async {
    // fill out authentication here

    // get auth service
    final _authService = AuthService();

    // check if password match && role is selected-> create user
    if (_role != null) {
      if (_formKey.currentState!.validate()) {
        // try creating user
        try {
          await _authService.signUpWithEmailPassword(
            emailController.text,
            passwordController.text,
            usernameController.text,
            _role,
          );

          // Navigate to profile creation
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CreateProfilScreen(role: _role),
            ),
          );
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

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   usernameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Form(
        key: _formKey,
        child: Center(
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

              // role dropdown
              DropdownButtonFormField(
                value: _role,
                decoration: InputDecoration(labelText: 'Role'),
                items: ['siswa', 'admin_stan'].map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _role = value.toString()),
              ),

              // sign up button
              MyButton(
                text: "Sign Up",
                onTap: () async {
                  // get auth service
                  final _authService = AuthService();

                  // check if password match && role is selected-> create user
                  if (_role != null) {
                    if (_formKey.currentState!.validate()) {
                      // try creating user
                      // try {
                      await _authService.signUpWithEmailPassword(
                        emailController.text,
                        passwordController.text,
                        usernameController.text,
                        _role,
                      );

                      // Navigate to profile creation
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateProfilScreen(role: _role),
                        ),
                      );
                    }

                    // display any errors
                    // catch (e) {
                    //   // showDialog(
                    //   //   context: context,
                    //   //   builder: (context) => AlertDialog(
                    //   //     title: Text(
                    //   //       e.toString(),
                    //   //     ),
                    //   //   ),
                    //   // );
                    //   print(e);
                    // }
                    // }
                  } else {
                    // // show error if no role selected
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => const AlertDialog(
                    //     title: Text("Please select role"),
                    //   ),
                    // );
                    print("Please select role");
                  }
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
      ),
    );
  }
}
