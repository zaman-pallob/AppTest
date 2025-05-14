import 'package:apptest/core/common_widget/cached_image.dart';
import 'package:apptest/core/constants/app_colors.dart';
import 'package:apptest/core/constants/app_text_style.dart';
import 'package:apptest/data/models/user_data_list_response.dart';
import 'package:apptest/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserData? userData;
  const UserDetailsScreen({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'User Details',
          style: fw600.copyWith(color: AppColors.white, fontSize: 16.sp),
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: CachedImage(
                  url: userData?.avatar ?? "",
                  height: 270.h,
                  boxFit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textRow("Id:", userData?.id.toString() ?? ""),
                    textRow("Name:",
                        "${userData?.firstName} ${userData?.lastName}"),
                    textRow("Email:", "${userData?.email}"),
                    textRow("Phone:", "N/A"),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget textRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: fw400.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: fw500.copyWith(fontSize: 14.sp),
            ),
          ]),
        ),
      ],
    );
  }
}
