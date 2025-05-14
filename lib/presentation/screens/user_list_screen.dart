import 'package:apptest/core/common_widget/search_box.dart';
import 'package:apptest/core/constants/app_colors.dart';
import 'package:apptest/presentation/providers/user_provider.dart';
import 'package:apptest/presentation/widgets/user_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/common_widget/error_widget.dart';
import '../../core/constants/app_text_style.dart';
import 'user_details_screen.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'User List',
          style: fw600.copyWith(color: AppColors.white, fontSize: 16.sp),
        ),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return Column(
          children: [
            SizedBox(height: 10.h),
            SearchBox(onChanged: (value) {
              userProvider.search(value);
            }),
            SizedBox(height: 5.h),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  userProvider.refresh();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    userListWidget(userProvider, context),
                    userProvider.isLoading
                        ? progressWidget()
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget userListWidget(UserProvider userProvider, BuildContext context) {
    if (userProvider.userList == null && !userProvider.isLoading) {
      return ErrorViewWidget(
        onRetry: () {
          userProvider.refresh();
        },
      );
    } else {
      if ((userProvider.userList?.isEmpty ?? true)) {
        if (userProvider.isLoading) {
          return SizedBox.shrink();
        } else {
          return noDataWidget();
        }
      } else {
        return ListView.builder(
          itemCount: userProvider.userList?.length,
          controller: userProvider.scrollController,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          itemBuilder: (_, index) {
            final userData = userProvider.userList?[index];
            return UserRowItem(
              name: "${userData?.firstName} ${userData?.lastName}",
              avaterUrl: userData?.avatar ?? "",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetailsScreen(userData: userData),
                  ),
                );
              },
            );
          },
        );
      }
    }
  }

  Widget noDataWidget() {
    return Center(
        child: Text(
      "No users avialable",
      style: fw400.copyWith(fontSize: 14.sp),
    ));
  }

  Widget progressWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
