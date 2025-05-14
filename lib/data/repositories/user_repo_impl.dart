import 'package:apptest/core/utils/connectivity.dart';
import 'package:apptest/data/datasources/local_storage.dart';
import 'package:apptest/domain/entities/user_data_entity.dart';
import 'package:apptest/domain/repositories/user_repository.dart';

import '../datasources/user_data_sources.dart';
import '../models/user_data_list_response.dart';

class UserRepoImpl implements UserRepository {
  UserDataSources userDataSources;
  LocalStorage localStorage;
  UserRepoImpl(this.userDataSources, this.localStorage);

  @override
  Future<UserDataEntity> getUsers({int page = 1, int limit = 10}) async {
    if (await hasInternetConnection()) {
      // If the device is connected to the internet, fetch data from the API
      var response = await userDataSources.getUsers(page: page, limit: limit);
      if (response.isDisconnected ?? false) {
        // If the device is disconnected, try to get data from local storage
        return await getDataFromLocalStorage(page);
      } else {
        if (response.userDataListResponse != null) {
          // Save the data to local storage if the response is successful
          await localStorage.saveData(
              page.toString(), response.userDataListResponse?.toJson());
        }
        // Return the response from the API
        return response;
      }
    } else {
      // If the device is disconnected, try to get data from local storage
      return getDataFromLocalStorage(page);
    }
  }

  Future<UserDataEntity> getDataFromLocalStorage(int page) async {
    var localData = await localStorage.getData(page.toString());
    var data =
        localData != null ? UserDataListResponse.fromJson(localData) : null;
    var entity =
        UserDataEntity(userDataListResponse: data, isDisconnected: true);
    return entity;
  }
}
