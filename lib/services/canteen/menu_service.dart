// Service untuk mengelola menu

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/models/add_on.dart';
import 'package:flutter_application_canteen/models/menu_item.dart';

class MenuService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Menambah menu baru
  Future<void> addMenu({
    required String stanId,
    required String name,
    required String description,
    required File imageFile,
    required double price,
    required List<AddOn> addOns,
  }) async {
    try {
      // upload gambar ke storage
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('menu_images/$fileName');
      await ref.putFile(imageFile);
      String imageUrl = await ref.getDownloadURL();

      // simpan data menu ke Firestore
      DocumentReference menuRef = _firestore.collection('menus').doc();
      MenuItem menuItem = MenuItem(
        id: menuRef.id,
        standId: stanId,
        name: name,
        description: description,
        imageUrl: imageUrl,
        price: price,
        addOns: addOns,
      );

      await menuRef.set(menuItem.toMap());
    } catch (e) {
      throw Exception('Failed to add menu: $e');
    }
  }

  // Menghapus menu
  Future<void> deleteMenu(String menuId) async {
    try {
      // ambil data untuk mendapatkan URL gambar
      DocumentSnapshot menu =
          await _firestore.collection('menus').doc(menuId).get();
      String imageUrl = menu.get('imageUrl');

      // hapus gambar dari storage
      Reference ref = _storage.refFromURL(imageUrl);
      await ref.delete();

      // hapus data menu dari firestore
      await _firestore.collection('menus').doc(menuId).delete();
    } catch (e) {
      throw Exception('Failed to delete menu: $e');
    }
  }

  Future<void> updateMenu({
    required String menuId,
    required String standId,
    required String name,
    required String description,
    required double price,
    required List<AddOn> addOns,
    File? newImageFile, // Optional, hanya jika gambar diubah
  }) async {
    try {
      // Persiapkan data yang akan diupdate
      Map<String, dynamic> updateData = {
        'standId': standId,
        'name': name,
        'description': description,
        'price': price,
        'addOns': addOns.map((addon) => addon.toMap()).toList(),
        'updateAt': FieldValue.serverTimestamp(),
      };

      // jika ada gambar baru yang diupload
      if (newImageFile != null) {
        // 1. Ambil data menu yang lama untuk mendapatkan URL gambar yang lama
        DocumentSnapshot menuDoc =
            await _firestore.collection('menus').doc(menuId).get();
        String oldImageUrl = menuDoc.get('imageUrl');

        // 2. Upload gambar baru ke storage
        String fileName =
            'menu_images/${DateTime.now().millisecondsSinceEpoch}';
        Reference ref = _storage.ref().child(fileName);
        await ref.putFile(newImageFile);
        String newImageUrl = await ref.getDownloadURL();

        // 3. Update data dengan URL gambar baru
        updateData['imageUrl'] = newImageUrl;

        // 4. Hapus gambar lama dari storage
        try {
          await FirebaseStorage.instance.refFromURL(oldImageUrl).delete();
        } catch (e) {
          print('Warning: Failed to delete old image: $e');
          // lanjutkan proses meskipun gagal menghapus gambar lama
        }
      }

      // Update dokumen di Firestore
      await _firestore.collection('menus').doc(menuId).update(updateData);
    } catch (e) {
      throw Exception('Failed to update menu: $e');
    }
  }

  // Mengambil menu berdasarkan stand
  Stream<List<MenuItem>> getMenuByStand(String stanId) {
    return _firestore
        .collection('menus')
        .where('standId', isEqualTo: stanId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => MenuItem(
                id: doc.id,
                standId: doc['standId'],
                name: doc['name'],
                description: doc['description'],
                imageUrl: doc['imageUrl'],
                price: doc['price'],
                addOns: (doc['addOns'] as List)
                    .map((addon) => AddOn(
                          name: addon['name'],
                          price: addon['price'],
                        ))
                    .toList(),
              ),
            )
            .toList());
  }
}
