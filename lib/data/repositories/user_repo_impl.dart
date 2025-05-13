import 'package:apptest/data/models/user_data_list_response.dart';
import 'package:apptest/domain/repositories/user_repository.dart';

import '../datasources/user_data_sources.dart';

class UserRepoImpl implements UserRepository {
  UserDataSources userDataSources;
  UserRepoImpl(this.userDataSources);

  @override
  Future<UserDataListResponse?> getUsers({int page = 1, int limit = 10}) async {
    UserDataListResponse? response =
        await userDataSources.getUsers(page: page, limit: limit);
    return response;
  }
}
