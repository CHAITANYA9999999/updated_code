import 'package:flutter/cupertino.dart';

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 1.2, size.height);
    path.lineTo(size.width, size.height / 1.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
