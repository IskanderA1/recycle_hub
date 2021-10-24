import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recycle_hub/style/theme.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    this.color = kColorGreen,
    this.size = 50
  });

  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: SpinKitCircle(
          color: color,
          size: size,
        ),
      ),
    );
  }
}
