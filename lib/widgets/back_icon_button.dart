
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackIconButton extends StatelessWidget {
  const BackIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            'assets/svg/back_arrow.svg',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
