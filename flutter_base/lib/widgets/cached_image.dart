import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String? imageUrl;
  final bool isRound;
  final double radius;
  final double height;
  final double width;

  final BoxFit fit;
  final String? placeholder;
  final bool isViewProfile;

  final String noImageAvailable = "https://www.esm.rochester.edu/uploads/NoPhotoAvailable.jpg";

  const CachedImage(
    this.imageUrl, {
    Key? key,
    this.isRound = true,
    this.radius = 50.0,
    this.isViewProfile = false,
    this.height = 50.0,
    this.width = 50.0,
    this.fit = BoxFit.cover,
    this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      var decoration = BoxDecoration(
        shape: isRound ? BoxShape.circle : BoxShape.rectangle,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
      );

      if (placeholder != null && placeholder!.isNotEmpty) {
        decoration = decoration.copyWith(
          image: DecorationImage(
            image: AssetImage(placeholder!),
            fit: BoxFit.cover,
          ),
        );
      }

      return CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        fit: fit,
        height: isRound ? radius : height,
        width: isRound ? radius : width,
        fadeInDuration: const Duration(milliseconds: 200),
        placeholder: (context, url) => Container(
          height: isRound ? radius : height,
          width: isRound ? radius : width,
          decoration: decoration,
        ),
        errorWidget: (context, url, error) => Container(
          height: isRound ? radius : height,
          width: isRound ? radius : width,
          decoration: decoration,
        ),
      );
    } catch (e) {
      return ClipOval(
        child: Image.network(
          noImageAvailable,
          height: isRound ? radius : height,
          width: isRound ? radius : width,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
