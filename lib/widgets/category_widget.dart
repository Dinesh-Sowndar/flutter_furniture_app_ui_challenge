import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  final Map category;
  final bool? isSelected;

  const CategoryWidget({super.key, required this.category, this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              category['icon']!,
              height: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          category['name']!,
          style: const TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        if (isSelected ?? false)
          const Icon(
            Icons.lens,
            color: Colors.white,
            size: 6,
          )
      ],
    );
  }
}
