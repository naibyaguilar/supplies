import 'package:flutter/material.dart';

class CustomPaintPages extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Path path1 = Path();
    double width = size.width / 414;
    double height = size.height / 230;
    path.lineTo(-49 * width, 69.4999 * height);
    path.cubicTo(
      -49 * width,
      69.4999 * height,
      22 * width,
      31.5004 * height,
      209.5 * width,
      115 * height,
    );
    path.cubicTo(
      397 * width,
      198.5 * height,
      426.5 * width,
      122 * height,
      426.5 * width,
      122 * height,
    );
    path.cubicTo(
      426.5 * width,
      122 * height,
      397 * width,
      -120 * height,
      397 * width,
      -120 * height,
    );
    path.cubicTo(
      397 * width,
      -120 * height,
      22 * width,
      -120 * height,
      22 * width,
      -120 * height,
    );
    path.cubicTo(
      22 * width,
      -120 * height,
      -49 * width,
      69.4999 * height,
      -49 * width,
      69.4999 * height,
    );
    path.cubicTo(
      -49 * width,
      69.4999 * height,
      -49 * width,
      69.4999 * height,
      -49 * width,
      69.4999 * height,
    );

    path1.lineTo(466 * width, 117.112 * height);
    path1.cubicTo(
      466 * width,
      117.112 * height,
      394.925 * width,
      66.3561 * height,
      207.228 * width,
      177.886 * height,
    );
    path1.cubicTo(
      19.531 * width,
      289.415 * height,
      -10 * width,
      187.235 * height,
      -10 * width,
      187.235 * height,
    );
    path1.cubicTo(
      -10 * width,
      187.235 * height,
      19.531 * width,
      -136 * height,
      19.531 * width,
      -136 * height,
    );
    path1.cubicTo(
      19.531 * width,
      -136 * height,
      394.925 * width,
      -136 * height,
      394.925 * width,
      -136 * height,
    );
    path1.cubicTo(
      394.925 * width,
      -136 * height,
      466 * width,
      117.112 * height,
      466 * width,
      117.112 * height,
    );
    path1.cubicTo(
      466 * width,
      117.112 * height,
      466 * width,
      117.112 * height,
      466 * width,
      117.112 * height,
    );

    return Path.combine(PathOperation.union, path1, path);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
