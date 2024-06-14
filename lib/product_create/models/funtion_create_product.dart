import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FuntionCreateProduct {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController priceController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();

  static final List<String> categories = [
    'comida',
    'bebida',
    'snack',
    'temporada'
  ];
  static String? selectedCategory;

  static Uint8List? fileBytes;
  static String? fileName;
  static String? imageUrl;

  Future<void> saveProduct(Function setStateImage) async {
    String name = FuntionCreateProduct.nameController.text.toLowerCase();
    double price =
        double.tryParse(FuntionCreateProduct.priceController.text) ?? 0.0;
    String description =
        FuntionCreateProduct.descriptionController.text.toLowerCase();

    if (FuntionCreateProduct.fileBytes != null &&
        name.isNotEmpty &&
        FuntionCreateProduct.selectedCategory != null) {
      bool productExists = await checkProductExists(name);

      if (productExists) {
        print('Product already exists');
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference<Map<String, dynamic>> productsCollection =
          firestore.collection('products').doc(name);

      await productsCollection.set({
        'name': name,
        'price': price,
        'description': description,
        'category': FuntionCreateProduct.selectedCategory,
        'img_url': FuntionCreateProduct.imageUrl,
      });

      print('Product saved');
      clearFields();
    } else {
      await uploadFile(setStateImage);
      print('Please select a file, enter a name, and select a category');
    }
  }

  Future<bool> checkProductExists(String name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('products')
        .where('name', isEqualTo: name)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> uploadFile(Function setStateImage) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      FuntionCreateProduct.fileBytes = result.files.first.bytes!;
      FuntionCreateProduct.fileName = result.files.first.name;

      // Upload file
      TaskSnapshot uploadTask = await FirebaseStorage.instance
          .ref('uploads/${FuntionCreateProduct.fileName}')
          .putData(FuntionCreateProduct.fileBytes!);

      // Get download URL
      FuntionCreateProduct.imageUrl = await uploadTask.ref.getDownloadURL();
      setStateImage();
    }
  }

  void clearFields() {
    FuntionCreateProduct.nameController.clear();
    FuntionCreateProduct.priceController.clear();
    FuntionCreateProduct.descriptionController.clear();
    FuntionCreateProduct.fileBytes = null;
    FuntionCreateProduct.fileName = null;
    FuntionCreateProduct.imageUrl = null;
    FuntionCreateProduct.selectedCategory = null;
  }
}
