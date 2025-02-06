import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/components/stan/add_addon_dialog.dart';
import 'package:flutter_application_canteen/models/add_on.dart';
import 'package:flutter_application_canteen/services/canteen/menu_service.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class AddMenuDialog extends StatefulWidget {
  final String stanId;

  AddMenuDialog({required this.stanId, Key? key}) : super(key: key);

  @override
  _AddMenuDialogState createState() => _AddMenuDialogState();
}

class _AddMenuDialogState extends State<AddMenuDialog> {
  final _formKey = GlobalKey<FormState>();
  final MenuService _menuService = MenuService();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  File? _imageFile;
  List<AddOn> _addOns = []; // list untuk menyimpan add-ons
  String _name = '';
  String _description = '';
  double _price = 0;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // fungsi untuk menambahkan add-on
  void _addAddOn() async {
    final result = await showDialog<AddOn>(
      context: context,
      builder: (context) => AddAddOnDialog(),
    );

    if (result != null) {
      setState(() {
        _addOns.add(result);
      });
    }
  }

  // fungsi untuk menghapus add-on
  void _removeAddOn(int index) {
    setState(() {
      _addOns.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Menu Item'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Menu'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: getImage,
                child: const Text('Pick Image'),
              ),
              _imageFile == null
                  ? const Text('No image selected')
                  : Image.file(
                      _imageFile!,
                      height: 100,
                    ),
              // Widget untuk menampilkan dan mengelola add-on
              const SizedBox(height: 16),
              const Text('Add-ons: '),
              Column(
                children: [
                  for (int i = 0; i < _addOns.length; i++)
                    ListTile(
                      title: Text(_addOns[i].name),
                      subtitle: Text('Price: ${_addOns[i].price}'),
                      trailing: IconButton(
                        onPressed: () => _removeAddOn(i),
                        icon: const Icon(Iconsax.trash),
                      ),
                    ),
                ],
              ),
              ElevatedButton(
                onPressed: _addAddOn,
                child: const Text("Add Add-on"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // panggil menu service untuk menambah menu
              try {
                await MenuService().addMenu(
                  stanId: widget.stanId,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  imageFile: _imageFile!,
                  price: double.parse(_priceController.text),
                  addOns: _addOns,
                );
                Navigator.of(context).pop(true);
              } catch (e) {
                // tampilkan error
                print('Error adding menu: $e');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to add menu: $e'),
                  ),
                );
              }
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
