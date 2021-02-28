import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CustomPainterFirst extends StatefulWidget {
  const CustomPainterFirst({Key key}) : super(key: key);

  @override
  _CustomPainterFirstState createState() => _CustomPainterFirstState();
}

class _CustomPainterFirstState extends State<CustomPainterFirst> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: StepperYellowCustomPainterFirst(
              size: MediaQuery.of(context).size),
        ),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter:
              StepperGreenCustomPainterFirst(size: MediaQuery.of(context).size),
        ),
      ],
    );
  }
}

class StepperGreenCustomPainterFirst extends CustomPainter {
  StepperGreenCustomPainterFirst({@required this.size});
  final Size size;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kColorGreen
      ..style = PaintingStyle.fill;

    Path path = _getClipFirst(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StepperYellowCustomPainterFirst extends CustomPainter {
  StepperYellowCustomPainterFirst({@required this.size});
  final Size size;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kColorSteperLightGreen
      ..style = PaintingStyle.fill;

    Path path = _getClipFirstYellow(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path _getClipFirst(Size size) {
  Path path = Path();
  path.moveTo(0, 0); // Start
  path.lineTo(0, size.height * 0.35);
  path.quadraticBezierTo(size.width * 0.30, size.height * 0.43,
      size.width * 0.55, size.height * 0.45);
  path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.467, size.width, size.height * 0.60);
  path.lineTo(size.width, 0);
  path.lineTo(0, 0);
  return path;
}

Path _getClipFirstYellow(Size size) {
  Path path = Path();
  path.moveTo(0, 0); // Start
  path.lineTo(0, size.height * 0.38);
  path.quadraticBezierTo(size.width * 0.30, size.height * 0.46,
      size.width * 0.55, size.height * 0.48);
  path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.497, size.width, size.height * 0.63);
  path.lineTo(size.width, 0);
  path.lineTo(0, 0);
  return path;
}
