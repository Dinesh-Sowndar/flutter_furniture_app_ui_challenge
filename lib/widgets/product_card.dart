import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map product;

  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          color: product['color'] as Color,
        ),
        child: Center(
          child: Image.asset(
            product['image'] as String,
          ),
        ),
      ),
    );
  }
}
