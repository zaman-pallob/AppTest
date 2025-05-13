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
  List<UserData>? userList;
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
    isLoading = true;
    await getUserList();
  }

  Future getUserList({int page = 1}) async {
    UserDataListResponse? response =
        await userController.getUserList(page, limit);
    if (response != null) {
      if (userList == null) {
        userList = response.data;
      } else {
        userList?.addAll(response.data ?? []);
      }
      totalPage = response.totalPages ?? 1;
    }
    isLoading = false;
  }
}
