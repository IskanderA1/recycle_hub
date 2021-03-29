import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class PartImagePainter extends StatefulWidget {
  //final String imageUrl;
  final Rect rect;
  final ui.Image image;
  final Key key;

  PartImagePainter({@required this.rect, this.image, this.key})
      : super(key: key);

  @override
  _PartImagePainterState createState() => _PartImagePainterState();
}

class _PartImagePainterState extends State<PartImagePainter> {
  @override
  Widget build(BuildContext context) {
    return paintImage(widget.image);
  }

  paintImage(image) {
    return CustomPaint(
      painter: ImagePainter(image, widget.rect),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: widget.rect.height,
      ),
    );
  }
}

class ImagePainter extends CustomPainter {
  ui.Image resImage;

  Rect rectCrop;

  ImagePainter(this.resImage, this.rectCrop);

  @override
  void paint(Canvas canvas, Size size) {
    if (resImage == null) {
      return;
    }
    final Rect rect = Offset.zero & size;
    final Size imageSize =
        Size(resImage.width.toDouble(), resImage.height.toDouble());
    FittedSizes sizes = applyBoxFit(BoxFit.fitWidth, imageSize, size);

    Rect inputSubRect = rectCrop;
    final Rect outputSubRect =
        Alignment.center.inscribe(sizes.destination, rect);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;
    canvas.drawRect(rect, paint);

    canvas.drawImageRect(resImage, inputSubRect, outputSubRect, Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
