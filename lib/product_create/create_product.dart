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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Uint8List? _fileBytes;
  String? _fileName;
  String? _imageUrl;

  Future<void> _saveProduct() async {
    String name = _nameController.text;
    double price = double.parse(_priceController.text);
    String description = _descriptionController.text;

    if (_fileBytes != null && name.isNotEmpty) {
      bool productExists = await _checkProductExists(name);

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
        'img_url': _imageUrl,
      });

      print('Product saved');
    } else {
      await _uploadFile();
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

      // Get download URL
      String downloadUrl = await FirebaseStorage.instance
          .ref('uploads/$_fileName')
          .getDownloadURL();

      setState(() {
        _imageUrl = downloadUrl;
      });
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
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: _uploadFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 16.0),
            _imageUrl != null
                ? Image.network(
                    _imageUrl!,
                    width: 300, // Set the desired width
                    height: 400, // Set the desired height
                    fit: BoxFit
                        .cover, // Adjust the image to fit the specified dimensions
                  )
                : Container(),
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
