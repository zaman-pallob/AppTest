import 'package:apptest/core/common_widget/circular_avater.dart';
import 'package:apptest/core/utils/app_colors.dart';
import 'package:apptest/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRowItem extends StatelessWidget {
  final String? name;
  final String? avaterUrl;
  const UserRowItem({
    super.key,
    this.name,
    this.avaterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray.withValues(alpha: 0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          CircularAvater(
            imageUrl: avaterUrl ?? "",
            height: 50.h,
            width: 50.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              children: [
                Text(
                  name ?? 'N/A',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: fw500.copyWith(fontSize: 15.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
