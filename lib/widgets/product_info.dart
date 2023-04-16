
import 'package:flutter/material.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Bosnas Posna",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        Text(
          "Footstool with storage, Ransta",
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "124\$",
          style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
