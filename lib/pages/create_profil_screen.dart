import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/my_textfield.dart';
import 'package:flutter_application_canteen/services/auth/auth_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfilScreen extends StatefulWidget {
  final String role;

  const CreateProfilScreen({super.key, required this.role});

  @override
  State<CreateProfilScreen> createState() => _CreateProfilScreenState();
}

class _CreateProfilScreenState extends State<CreateProfilScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  // Define TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String? fotoUrl;

  // Dispose controllers when the widget is disposed
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Profile'),
      ),
      body: Form(
          child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                labelText: widget.role == 'siswa' ? 'Nama Siswa' : 'Nama Stan'),
            validator: (value) => value!.isEmpty ? 'enter a name' : null,
          ),
          TextFormField(
            controller: phoneNumberController,
            decoration: InputDecoration(
              labelText: 'Telp',
            ),
            validator: (value) =>
                value!.isEmpty ? 'enter a phone number' : null,
          ),
          if (widget.role == 'siswa') ...[
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Alamat'),
              validator: (value) => value!.isEmpty ? 'Enter an address' : null,
            ),

            const SizedBox(
              height: 16,
            ),

            // image preview
            if (fotoUrl != null)
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    fotoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(
              height: 8,
            ),

            // image picker button
            ElevatedButton.icon(
              icon: Icon(Icons.photo_camera),
              label: Text('Upload Foto'),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  // upload to Firebase Storage
                  final storageRef = FirebaseStorage.instance.ref();
                  final photoRef =
                      storageRef.child('profile_photos/${DateTime.now()}.jpg');

                  try {
                    // Upload the file
                    await photoRef.putFile(File(image.path));

                    // get the download URL
                    final downloadUrl = await photoRef.getDownloadURL();

                    setState(() {
                      fotoUrl = downloadUrl;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Error Uploading Image: $e',
                        ),
                      ),
                    );
                  }
                }
              },
            )
          ]
        ],
      )),
    );
  }
}
