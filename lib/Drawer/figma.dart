import 'package:flutter/material.dart';

class Vector1 extends StatelessWidget {
  const Vector1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          "assets/logos/img_3.png",
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Image.asset("assets/logos/img_4.png",fit: BoxFit.cover,width: double.infinity,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 240,
            height: 35,
            decoration: ShapeDecoration(
              color: const Color(0xFF6A74CF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(77),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 4,
                  offset: Offset(0, 3),
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
