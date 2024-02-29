import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class CreateProductPage extends StatefulWidget {
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  TextEditingController _nameController = TextEditingController();
  Uint8List? _fileBytes;
  String? _fileName;

  Future<void> _saveProduct() async {
    String name = _nameController.text;

    if (_fileBytes != null && name.isNotEmpty) {
      bool productExists = await _checkProductExists(name);

      if (productExists) {
        print('Product already exists');
        return;
      }

      // await _uploadFile();

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference productsCollection = firestore.collection('products');

      await productsCollection.add({
        'name': name,
        'img_url': 'gs://pasteles-882b1.appspot.com/uploads/$_fileName',
      });

      print('Product saved');
    } else {
      print('Please select a file and enter a name');
    }
  }

  Future<bool> _checkProductExists(String name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection('products')
        .where('name', isEqualTo: name)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _fileBytes = result.files.first.bytes!;
      _fileName = result.files.first.name;

      // Upload file
      await FirebaseStorage.instance
          .ref('uploads/$_fileName')
          .putData(_fileBytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
