import 'package:apptest/core/constants/app_colors.dart';
import 'package:apptest/core/utils/toast.dart';
import 'package:apptest/data/models/user_data_list_response.dart';
import 'package:apptest/domain/usecase/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ScrollController scrollController = ScrollController();
  int currentPage = 1, limit = 10, totalPage = 1;
  List<UserData>? userList, tempUserList;
  UserController userController;

  UserProvider(this.userController) {
    initialize();
  }

  initialize() {
    getUserList();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          scrollController.position.atEdge) {
        if (currentPage < totalPage) {
          isLoading = true;
          currentPage++;
          getUserList(page: currentPage);
        } else {
          Toasts.show(
            'No more data available',
            textColor: AppColors.white,
            color: AppColors.successColor,
          );
        }
      }
    });
  }

  refresh() async {
    currentPage = 1;
    userList = null;
    tempUserList = null;
    isLoading = true;
    await getUserList();
  }

  Future getUserList({int page = 1}) async {
    var data = await userController.getUserList(page, limit);

    if (data.isDisconnected ?? false) {
      Toasts.showSnackbar(
          "Either no internet connection or internet is too slow to reach the server!!!'",
          () async {
        isLoading = true;
        await Future.delayed(const Duration(seconds: 2));
        getUserList(page: page);
      });
    }
    if (data.userDataListResponse != null) {
      currentPage = data.userDataListResponse?.page ?? 1;
      totalPage = data.userDataListResponse?.totalPages ?? 1;
      if (userList == null) {
        userList = data.userDataListResponse?.data ?? [];
      } else {
        userList?.addAll(data.userDataListResponse?.data ?? []);
      }
    }
    tempUserList = userList;
    isLoading = false;
  }

  search(String query) {
    if (query.isEmpty) {
      userList = tempUserList;
    } else {
      // Remove special characters from the query string
      var regxp = RegExp(r'[^\w\s]');
      String value = RegExp.escape(query.trim().replaceAll(regxp, ''));
      if (tempUserList?.isNotEmpty ?? false) {
        userList = tempUserList?.where((user) {
              //Remove special characters from the name string and convert to lowercase
              String name = RegExp.escape("${user.firstName} ${user.lastName}"
                  .replaceAll(regxp, '')
                  .toLowerCase());
              // Convert query to lowercase for case-insensitive search
              return name.contains(value.toLowerCase());
            }).toList() ??
            [];
      }
    }

    notifyListeners();
  }
}
