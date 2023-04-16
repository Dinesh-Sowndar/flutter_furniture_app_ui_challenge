import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:furnitures_app/const.dart';
import 'package:furnitures_app/widgets/back_icon_button.dart';
import 'package:furnitures_app/widgets/category_widget.dart';
import 'package:furnitures_app/widgets/product_info.dart';
import 'package:furnitures_app/widgets/rounded_buttons.dart';

class DetailsPage extends StatefulWidget {
  final Offset catListOffset;
  final int selectedCat;

  const DetailsPage(
      {super.key, required this.catListOffset, required this.selectedCat});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  int selectedCat = 0;
  int selectedColor = 0;
  int qty = 0;
  bool showDragWidget = false;
  Offset dragOffset = const Offset(0, 0);
  double targetDistance = 0.0;

  late AnimationController _imagePulseController;
  late AnimationController _qtyPulseController;

  GlobalKey fabKey = GlobalKey();
  GlobalKey imageKey = GlobalKey();

  Offset fabOffset() => (fabKey.currentContext!.findRenderObject() as RenderBox)
      .localToGlobal(Offset.zero);

  Offset imageOffset() =>
      (imageKey.currentContext!.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);

  _onLongPressStart(LongPressStartDetails details) {
    setState(() {
      dragOffset = Offset(imageOffset().dx - 30, imageOffset().dy - 180);
      showDragWidget = true;
      qty = 0;
    });
  }

  _onLongPressEnd(LongPressEndDetails details) {
    if (targetDistance > 80) {
      targetDistance = 140;
      dragOffset = Offset(fabOffset().dx - 85, fabOffset().dy - 270);
      addQty();
    } else {
      targetDistance = 0;
      dragOffset = Offset(imageOffset().dx, imageOffset().dy - 192);
      setState(() {});
    }

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        showDragWidget = false;
        targetDistance = 0;
      });
    });
  }

  _onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    var position = details.globalPosition;
    setState(() {
      dragOffset = Offset(position.dx - 100, position.dy - 192);
    });

    double offDistance = (dragOffset - fabOffset()).distance;

    if (offDistance < 400 && offDistance > 250) {
      targetDistance = (400.0 - offDistance);
    }
  }

  addQty() async {
    setState(() {
      qty = 1;
    });
    await Future.delayed(const Duration(seconds: 1));
    _qtyPulseController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _qtyPulseController.reverse();
  }

  @override
  void initState() {
    super.initState();
    selectedCat = widget.selectedCat;
    _imagePulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _qtyPulseController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _imagePulseController.dispose();
    _qtyPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                tween: Tween(begin: 1, end: 0),
                builder: (context, double value, _) {
                  return Hero(
                      tag: 'blue_card',
                      child: Material(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(value * 15),
                          ),
                        ),
                      ));
                }),
            const BackIconButton(),
            Positioned(
              top: 80,
              child: categoryWithoutTag(),
            ),
            Positioned(
              top: widget.catListOffset.dy,
              child: categoryWithTag(),
            ),
            Positioned(
              top: 190,
              right: 0,
              left: 0,
              bottom: 0,
              child: SlideInUp(
                delay: const Duration(milliseconds: 1200),
                duration: const Duration(milliseconds: 600),
                from: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.0),
                          topRight: Radius.circular(35.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 4,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 1.0,
                                      end: 1.2,
                                    ).animate(_imagePulseController),
                                    child: GestureDetector(
                                      onLongPressStart: _onLongPressStart,
                                      onLongPressEnd: _onLongPressEnd,
                                      onLongPressMoveUpdate:
                                          _onLongPressMoveUpdate,
                                      child: SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.asset(
                                          "assets/images/box_colors/${colors[selectedColor]['colorName']}.png",
                                          key: imageKey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const ProductInfo(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var i = 0; i < colors.length; i++)
                                        Radio(
                                          value: i,
                                          groupValue: selectedColor,
                                          onChanged: (int? value) {
                                            _imagePulseController.forward();
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 200), () {
                                              _imagePulseController.reverse();
                                              setState(() {
                                                selectedColor = value!;
                                              });
                                            });
                                          },
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) => colors[i]["color"]
                                                      as Color),
                                          activeColor:
                                              colors[i]["color"] as Color,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const RoundedButtons(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: Stack(
                          key: fabKey,
                          alignment: AlignmentDirectional.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 60 + targetDistance,
                              height: 60 + targetDistance,
                              transform: Matrix4.rotationZ(
                                  targetDistance * math.pi / 90),
                              transformAlignment: Alignment.center,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/gradient.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            Center(
                              child: Image.asset(
                                "assets/images/bag.png",
                                width: 21 + targetDistance / 20,
                              ),
                            ),
                            Positioned(
                              right: 24,
                              top: 24,
                              child: AnimatedOpacity(
                                opacity: qty > 0 ? 1 : 0,
                                duration: Duration(
                                    milliseconds: qty > 0 ? 1000 : 100),
                                curve: Curves.easeIn,
                                child: ScaleTransition(
                                  scale: Tween<double>(
                                    begin: 1.0,
                                    end: 1.4,
                                  ).animate(_qtyPulseController),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    height: qty > 0 ? 16 : 1,
                                    width: qty > 0 ? 16 : 1,
                                    transform: Matrix4.rotationZ(
                                        targetDistance < 100
                                            ? 0
                                            : -50 * math.pi / 90),
                                    transformAlignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        qty.toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (showDragWidget)
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 100),
                        top: dragOffset.dy + targetDistance,
                        left: dragOffset.dx + targetDistance,
                        child: SizedBox(
                          height: (150 - targetDistance).abs(),
                          width: (150 - targetDistance).abs(),
                          child: Image.asset(
                            "assets/images/box_colors/${colors[selectedColor]['colorName']}.png",
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget categoryWithTag() {
    return FadeOut(
      child: Hero(
        tag: "cat",
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 90,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.only(left: 5),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CategoryWidget(
                      category: categories[index],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryWithoutTag() {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categories.length,
        padding: const EdgeInsets.only(left: 5),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SlideInUp(
            key: Key(index.toString()),
            delay: Duration(milliseconds: 200 + (100 * index)),
            from: widget.catListOffset.dy - 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedCat = index;
                  });
                },
                child: CategoryWidget(
                  category: categories[index],
                  isSelected: selectedCat == index,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
