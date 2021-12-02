import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets.dart';

class CupertinoSelectImageActionSheet extends StatelessWidget {
  final String? title;

  const CupertinoSelectImageActionSheet({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Texts(
        title ?? 'Choose Upload Options',
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.5,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Texts(
            'Camera',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        CupertinoActionSheetAction(
          child: Texts(
            'Gallery',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Texts('Cancel'),
        isDefaultAction: true,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
