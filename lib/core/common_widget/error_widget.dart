import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class ErrorViewWidget extends StatelessWidget {
  final String? errorMessage;
  final Function()? onRetry;
  const ErrorViewWidget({super.key, this.errorMessage, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Container(
          height: 150.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGray.withValues(alpha: 0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                errorMessage ?? "Something went wrong!!!",
                style: fw400.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.errorColor,
                ),
              ),
              onRetry != null
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          onRetry!();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.infoColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Retry",
                              style: fw400.copyWith(
                                fontSize: 14.sp,
                                color: AppColors.white,
                              ),
                            ),
                            Icon(
                              Icons.refresh,
                              color: AppColors.white,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }
}
