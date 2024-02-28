import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;

  Product(
      {required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.size,
      required this.id,
      required this.color});
}

List<Product> products = [
  Product(
      id: 1,
      title: "pastel de chocolate",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/box1.jpeg",
      color: Color(0xFF3D82AE)),
  Product(
      id: 2,
      title: "panque",
      price: 234,
      size: 8,
      description: dummyText,
      image: "assets/images/box2.jpeg",
      color: Color(0xFFD3A984)),
  Product(
      id: 3,
      title: "pastel de vainilla",
      price: 234,
      size: 10,
      description: dummyText,
      image: "assets/images/box3.jpeg",
      color: Color(0xFF989493)),
  Product(
      id: 4,
      title: "pastel relleno",
      price: 234,
      size: 11,
      description: dummyText,
      image: "assets/images/box4.jpeg",
      color: Color(0xFFE6B398)),
  Product(
      id: 5,
      title: "pastel de coco rayado",
      price: 234,
      size: 12,
      description: dummyText,
      image: "assets/images/box5.jpeg",
      color: Color(0xFFFB7883)),
  Product(
    id: 6,
    title: "pastel con nuez",
    price: 234,
    size: 12,
    description: dummyText,
    image: "assets/images/box6.jpeg",
    color: Color(0xFFAEAEAE),
  ),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
