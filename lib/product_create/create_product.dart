// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:pastel/product_create/models/funtion_create_product.dart';
// import 'dart:typed_data';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
<<<<<<< HEAD
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
=======
  void setStateImage() {
    setState(() {});
>>>>>>> refs/remotes/origin/main
  }

  void selectCategory(selected, category) {
    setState(() {
      FuntionCreateProduct.selectedCategory = selected ? category : null;
      print(FuntionCreateProduct.selectedCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: FuntionCreateProduct.nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: FuntionCreateProduct.priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: FuntionCreateProduct.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: FuntionCreateProduct.categories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: FuntionCreateProduct.selectedCategory == category,
                  onSelected: (selected) {
                    selectCategory(selected, category);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            if (FuntionCreateProduct.imageUrl != null)
              Image.network(
                FuntionCreateProduct.imageUrl!,
                key: ValueKey(FuntionCreateProduct.imageUrl),
                width: 300,
                height: 400,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                FuntionCreateProduct().uploadFile(setStateImage);
              },
              child: const Text('Select File'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                FuntionCreateProduct().saveProduct(setStateImage);
              },
              child: const Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
