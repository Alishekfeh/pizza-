import 'package:flutter/material.dart';

class AppClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path=Path();
      path.moveTo(0, 0);
      path.quadraticBezierTo(30, 0, 40, 25);
      path.quadraticBezierTo(size.width/2, 50, size.width-40, 20);
      path.quadraticBezierTo(size.width -30, 0, size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
