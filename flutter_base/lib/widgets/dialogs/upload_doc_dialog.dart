import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/utils/base_utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../flutter_base.dart';
import '../widgets.dart';

class ImageDialog extends StatelessWidget {
  final String? title;
  final BoxDecoration? decoration;
  final Function(String, String, dynamic file) onPick;

  const ImageDialog({
    Key? key,
    required this.onPick,
    this.title,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Texts(title ?? 'Choose image'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      content: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => pick(context, ImageSource.camera),
              child: Container(
                height: 100,
                decoration: decoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                child: const Center(
                  child: Texts(
                    "Camera",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: InkWell(
              onTap: () => pick(context, ImageSource.gallery),
              child: Container(
                height: 100,
                decoration: decoration ??
                    BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                child: const Center(
                  child: Texts(
                    "Gallery",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Texts('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  void pick(BuildContext context, ImageSource source) async {
    try {
      Navigator.pop(context);
      final result = await BaseUtils.pickImage(source);

      if (result != null) {
        File? file;
        String fileName = "", filePath = "";

        /// if its not null then we will surely have file
        /// and its attributes in result data

        file = result['file'];
        fileName = result['file_name'];
        filePath = result['file_path'];

        onPick(fileName, filePath, file);
      }
    } catch (e) {
      showLog("pickImage exception =====>>> $e");
    }
  }
}
