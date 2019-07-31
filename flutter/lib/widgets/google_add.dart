import 'package:flutter/material.dart';

class GoogleAdd extends StatelessWidget {
  const GoogleAdd({Key key, this.size = 24}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(
        painter: _Painter(),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final _paintRed = Paint()..color = const Color(0xFFDE3A2F);
  final _paintBlue = Paint()..color = const Color(0xFF367BF4);
  final _paintGreen = Paint()..color = const Color(0xFF299E49);
  final _paintYellow = Paint()..color = const Color(0xFFF9B30B);

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 6;
    final width = size.width;
    final leading = (width - strokeWidth) / 2;
    final trailing = (width + strokeWidth) / 2;

    canvas
      ..drawPath(
        Path()
          ..moveTo(leading, 0)
          ..lineTo(trailing, 0)
          ..lineTo(trailing, leading)
          ..lineTo(leading, trailing)
          ..close(),
        _paintRed,
      )
      ..drawPath(
        Path()
          ..moveTo(trailing, leading)
          ..lineTo(width, leading)
          ..lineTo(width, trailing)
          ..lineTo(leading, trailing)
          ..close(),
        _paintBlue,
      )
      ..drawPath(
        Path()
          ..moveTo(leading, trailing)
          ..lineTo(trailing, trailing)
          ..lineTo(trailing, width)
          ..lineTo(leading, width)
          ..close(),
        _paintGreen,
      )
      ..drawPath(
        Path()
          ..moveTo(0, leading)
          ..lineTo(leading, leading)
          ..lineTo(leading, trailing)
          ..lineTo(0, trailing)
          ..close(),
        _paintYellow,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
