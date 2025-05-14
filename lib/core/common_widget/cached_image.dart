// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_images.dart';

class CachedImage extends StatelessWidget {
  final String url;
  BoxFit? boxFit;
  String? placeHolder;
  double? width, height;
  BorderRadius? borderRadius;
  CachedImage(
      {super.key,
      required this.url,
      this.boxFit,
      this.placeHolder,
      this.borderRadius,
      this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(10.r),
      child: SizedBox(
        width: width ?? double.infinity,
        height: height,
        child: CachedNetworkImage(
            height: height,
            imageUrl: url,
            fit: boxFit ?? BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
                  placeHolder ?? AppImages.avater,
                  fit: boxFit ?? BoxFit.contain,
                ),
            placeholder: (context, url) => Image.asset(
                  placeHolder ?? AppImages.avater,
                  fit: boxFit ?? BoxFit.contain,
                )),
      ),
    );
  }
}
