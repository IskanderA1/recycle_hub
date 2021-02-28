import 'package:flutter/material.dart';
import 'package:recycle_hub/style/theme.dart';

class CustomPainterSecond extends StatefulWidget {
  @override
  _CustomPainterSecondState createState() => _CustomPainterSecondState();
}

class _CustomPainterSecondState extends State<CustomPainterSecond> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: StepperYellowCustomPainterSecond(
              size: MediaQuery.of(context).size),
        ),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: StepperGreenCustomPainterSecond(
              size: MediaQuery.of(context).size),
        ),
      ],
    );
  }
}

class StepperGreenCustomPainterSecond extends CustomPainter {
  StepperGreenCustomPainterSecond({@required this.size});
  final Size size;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kColorGreen
      ..style = PaintingStyle.fill;

    Path path = _getGreenClipSecond(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StepperYellowCustomPainterSecond extends CustomPainter {
  StepperYellowCustomPainterSecond({@required this.size});
  final Size size;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kColorSteperLightGreen
      ..style = PaintingStyle.fill;

    Path path = _getYellowClipSecond(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Path _getGreenClipSecond(Size size) {
  Path path = Path();
  path.moveTo(0, size.height); // Start
  path.lineTo(0, size.height * 0.63);
  path.quadraticBezierTo(size.width * 0.30, size.height * 0.53,
      size.width * 0.55, size.height * 0.50);
  path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.47, size.width, size.height * 0.35);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  return path;
}

Path _getYellowClipSecond(Size size) {
  Path path = Path();
  path.moveTo(0, size.height); // Start
  path.lineTo(0, size.height * 0.60);
  path.quadraticBezierTo(size.width * 0.30, size.height * 0.50,
      size.width * 0.55, size.height * 0.47);
  path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.44, size.width, size.height * 0.32);
  path.lineTo(size.width, size.height);
  path.lineTo(0, size.height);
  return path;
}
