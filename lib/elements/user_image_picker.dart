import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recycle_hub/helpers/file_uploader.dart';
import 'package:recycle_hub/helpers/image_picker.dart';
import 'package:recycle_hub/style/theme.dart';

class UserImagePicker extends StatefulWidget {
  final String image;
  final Function(bool) onSelected;
  UserImagePicker({this.image, this.onSelected});
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  bool _isLoading = true;

  @override
  void initState() {
    if (widget.image != null && widget.image.isNotEmpty) {
      _loadImage(widget.image);
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
        this._image = img;
        await FileUpLoader.sendPhoto(_image, '/update_profile_image', context);
      }
      if (widget.onSelected != null) {
        widget.onSelected(true);
      }
      setState(() {});
    } catch (e) {
      _image = null;
    }
  }

  Future<void> _loadImage(String imageUrl) async {
    try {
      this._image = await File.fromUri(Uri.parse(imageUrl));
    } on Exception catch (e) {
      this._image = null;
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
              child:
                  /* image != null
                        ? Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(3.0),
                              color: const Color(0xff7c94b6),
                              image: new DecorationImage(
                                image: new NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        :  */
                  _image != null
                      ? Image.file(_image)
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
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: kColorWhite),
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
