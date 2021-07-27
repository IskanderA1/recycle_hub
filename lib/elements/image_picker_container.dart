import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_hub/helpers/image_picker.dart';
import 'package:recycle_hub/style/theme.dart';

class ImagePickerContainer extends StatefulWidget {
  final List<File> images;
  final Function(File image) onAdded;
  final Function(File image) onDelete;
  final ScrollController controller;
  ImagePickerContainer(
      {this.images, this.onAdded, this.onDelete, this.controller});
  @override
  _ImagePickerContainerState createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  List<File> _images;
  final picker = ImagePicker();
  ScrollController scrollController;

  @override
  void initState() {
    if (widget.images != null) {
      _images = widget.images;
    } else {
      _images = [];
    }
    if (widget.controller != null) {
      this.scrollController = widget.controller;
    } else {
      scrollController = ScrollController();
    }
    super.initState();
  }

  Future _getImage() async {
    try {
      final img = await FilePicker.getImage();
      _images.add(img);
      if (widget.onAdded != null && widget.images == null) {
        widget.onAdded(img);
      }
      setState(() {});
    } catch (e) {}
  }

  Future _getImageFromStorage() async {
    try {
      final img = await FilePicker.getImageFromStorage();
      if (widget.onAdded != null && widget.images == null) {
        widget.onAdded(img);
      }
      _images.add(img);
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      controller: scrollController,
      children: [
        ListView.builder(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Image.file(
                _images[index],
                fit: BoxFit.scaleDown,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded ?? false) {
                    return child;
                  }
                  return AnimatedOpacity(
                    child: Stack(
                      children: <Widget>[
                        child,
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(25),
                            child: GestureDetector(
                              onTap: () {
                                if (widget.onDelete != null && widget.images == null) {
                                  widget.onDelete(_images[index]);
                                }
                                _images.removeAt(index);
                                setState(() {});
                              },
                              child: Icon(Icons.close),
                            ),
                          ),
                        ),
                      ],
                    ),
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                },
              );
            }),
        Center(
          child: Text(
            "Добавить фото",
            style: TextStyle(
                fontFamily: 'GillroyMedium',
                fontSize: 16,
                color: Color(0xFF8D8D8D)),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
                onTap: () => _getImageFromStorage(),
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: kColorGreen,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Из устройства",
                      style: TextStyle(
                          color: kColorWhite,
                          fontFamily: 'GillroyMedium',
                          fontSize: 14),
                    ),
                  ),
                )),
            Spacer(),
            GestureDetector(
                onTap: () => _getImage(),
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: const Color(0xFFECECEC),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Text(
                      "Камера",
                      style: TextStyle(
                          color: kColorBlack,
                          fontFamily: 'GillroyMedium',
                          fontSize: 14),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
