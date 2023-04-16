import 'package:flutter/material.dart';

class RoundedButtons extends StatelessWidget {
  const RoundedButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: const Size(110, 38),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              elevation: 0.5),
          onPressed: () {},
          child: const Text(
            'Add to Cart',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(110, 38),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              elevation: 0.5),
          onPressed: () {},
          child: const Text(
            'Buy Now',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
