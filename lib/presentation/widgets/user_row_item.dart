import 'package:apptest/core/common_widget/circular_avater.dart';
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.4),
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
          const SizedBox(width: 10),
          Text(
            name ?? 'N/A',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
