import 'package:apptest/core/constants/app_colors.dart';
import 'package:apptest/core/constants/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularAvater extends StatelessWidget {
  final String imageUrl;
  final double width, height;
  const CircularAvater({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
              width: 1.w, color: AppColors.primaryColor.withValues(alpha: 0.1)),
          image: DecorationImage(
            image: getImage(imageUrl),
            fit: BoxFit.contain,
          ),
          shape: BoxShape.circle),
    );
  }

  ImageProvider getImage(String imageUrl) {
    try {
      if (imageUrl == "") {
        return AssetImage(AppImages.avater);
      } else {
        return CachedNetworkImageProvider(imageUrl);
      }
    } catch (e) {
      return AssetImage(AppImages.avater);
    }
  }
}
