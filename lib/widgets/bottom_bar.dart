import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static const List<String> _iconPaths = [
    'assets/svg/home.svg',
    'assets/svg/search.svg',
    'assets/svg/add.svg',
    'assets/svg/bell.svg',
    'assets/svg/user.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _iconPaths.length,
              (index) => buildNavItem(
                index: index,
                iconPath: _iconPaths[index],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({required int index, required String iconPath}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: _selectedIndex == index ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 5),
            Container(
              height: 2,
              width: 20,
              decoration: BoxDecoration(
                color:
                    _selectedIndex == index ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
