import 'package:apptest/core/network/exceptions.dart';
import 'package:apptest/core/utils/toast.dart';
import 'package:dio/dio.dart';

import '../models/user_data_list_response.dart';

class UserDataSources {
  Dio dio;
  UserDataSources(this.dio);

  Future<UserDataListResponse?> getUsers({int page = 1, int limit = 10}) async {
    UserDataListResponse? userDataListResponse;
    try {
      final response = await dio.get(
        '/users',
        queryParameters: {'page': page, 'per_page': limit},
      );

      if (response.statusCode == 200) {
        try {
          userDataListResponse = UserDataListResponse.fromJson(response.data);
          return userDataListResponse;
        } catch (e) {
          Toasts.show('Error: ${e.toString()}');
          return userDataListResponse;
        }
      } else if (response.statusCode == 404) {
        Toasts.show('No data found');
        return userDataListResponse;
      } else {
        return userDataListResponse;
      }
    } catch (e) {
      if (e is DioException) {
        String message = ExceptionMessage.getMessage(e);
        Toasts.show(message);
        return userDataListResponse;
      } else {
        Toasts.show(e.toString());
        return userDataListResponse;
      }
    }
  }
}
