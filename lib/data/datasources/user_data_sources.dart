import 'package:apptest/core/network/exceptions.dart';
import 'package:apptest/core/utils/toast.dart';
import 'package:apptest/domain/entities/user_data_entity.dart';
import 'package:dio/dio.dart';

import '../models/user_data_list_response.dart';

class UserDataSources {
  Dio dio;
  UserDataSources(this.dio);

  Future<UserDataEntity> getUsers({int page = 1, int limit = 10}) async {
    UserDataEntity userDataEntity = UserDataEntity(isDisconnected: false);
    try {
      final response = await dio.get(
        '/users',
        queryParameters: {'page': page, 'per_page': limit},
      );

      if (response.statusCode == 200) {
        try {
          var userDataListResponse =
              UserDataListResponse.fromJson(response.data);
          userDataEntity.userDataListResponse = userDataListResponse;
          return userDataEntity;
        } catch (e) {
          // Handle JSON parsing error
          Toasts.show('Error: ${e.toString()}');
          userDataEntity.userDataListResponse = null;
          return userDataEntity;
        }
      } else if (response.statusCode == 404) {
        Toasts.show('No data found');
        userDataEntity.userDataListResponse = null;
        return userDataEntity;
      } else {
        userDataEntity.userDataListResponse = null;
        return userDataEntity;
      }
    } catch (e) {
      if (e is DioException) {
        // Handle DioException
        String message = ExceptionMessage.getMessage(e);
        if (e.type == DioExceptionType.connectionError) {
          userDataEntity.isDisconnected = true;
        } else {
          Toasts.show(message);
        }
        userDataEntity.userDataListResponse = null;
        return userDataEntity;
      } else {
        // Handle other exceptions
        Toasts.show(e.toString());
        userDataEntity.userDataListResponse = null;
        return userDataEntity;
      }
    }
  }
}
