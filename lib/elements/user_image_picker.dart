import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/helpers/file_uploader.dart';
import 'package:recycle_hub/helpers/image_picker.dart';
import 'package:recycle_hub/style/theme.dart';

class UserImagePicker extends StatefulWidget {
  final String image;
  final Function(bool) onSelected;
  UserImagePicker({
    Key key,
    this.image,
    this.onSelected,
  }) : super(key: key);
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  bool _isLoading = true;
  Widget _imageWidget;

  @override
  void initState() {
    if (widget.image != null && widget.image.isNotEmpty) {
      try {
        _loadImage(widget.image);
      } catch (e) {
        print(e.toString());
      }
    } else {
      _image = null;
      _isLoading = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _selectImage() async {
    try {
      final img = await FilePicker.getImageFromStorage();
      if (img != null) {
        _image = img;
        await FileUpLoader.sendPhoto(_image, '/update_profile_image', context);
      }
      if (widget.onSelected != null) {
        widget.onSelected(true);
      }
      setState(() {
        _imageWidget = Image.file(
          _image,
          fit: BoxFit.cover,
        );
      });
    } catch (e) {
      _image = null;
    }
  }

  Future<void> _loadImage(String imageUrl) async {
    try {
      _imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      );
    } catch (e) {
      _image = null;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CupertinoActivityIndicator();
    }
    return Container(
      child: Stack(
        children: [
          Container(
            height: 82,
            width: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kColorGreyVeryLight,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(41),
              child: _imageWidget != null
                  ? _imageWidget
                  : Center(
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        color: kColorGreen,
                      ),
                    ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 50, left: 50),
            child: InkWell(
              onTap: () {
                _selectImage();
              },
              child: Container(
                alignment: Alignment.center,
                height: 31,
                width: 31,
                decoration: BoxDecoration(shape: BoxShape.circle, color: kColorWhite),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: kColorGreen,
                  size: 21,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
