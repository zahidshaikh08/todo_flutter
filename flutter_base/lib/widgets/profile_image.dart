import 'dart:io';

import 'package:flutter/material.dart';

import 'cached_image.dart';

class ProfileImage extends StatelessWidget {
  final VoidCallback? onTap;
  final String? imageFile;
  final String? imageUrl;

  /// used only if NO IMAGE IS SELECTED AND
  /// IF IMAGE IS SELECTED VIA LOCAL STORAGE
  final num? width;
  final num? height;

  /// used only with network image ignored for others
  /// radius should be (width/height) / 2 always
  final num? radius;

  const ProfileImage({
    Key? key,
    this.onTap,
    this.imageFile,
    required this.width,
    required this.height,
    required this.radius,
    this.imageUrl,
  }) : super(key: key);

  static const defaults = 100.0;

  @override
  Widget build(BuildContext context) {
    double? kWidth = width?.toDouble();
    double? kHeight = height?.toDouble();
    double? kRadius = radius?.toDouble();
    kRadius ??= 50;

    return Center(
      child: RawMaterialButton(
        onPressed: onTap,
        shape: const CircleBorder(),
        child: SizedBox(
          width: kWidth,
          height: kHeight,
          child: Column(
            children: <Widget>[
              imageUrl != null && imageUrl != "" && (imageFile == null || imageFile == "")
                  ? CachedImage(
                      imageUrl!,
                      radius: kRadius,
                      isRound: true,
                    )
                  : imageFile == null
                      ? CircleAvatar(
                          radius: kRadius,
                          backgroundColor: Colors.grey[300],
                          child: Icon(
                            Icons.add,
                            color: Theme.of(context).primaryColor,
                            size: kRadius * 0.85,
                          ),
                        )
                      : ClipOval(
                          child: Image.file(
                            File(imageFile!),
                            width: kWidth,
                            height: kHeight,
                            fit: BoxFit.cover,
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
