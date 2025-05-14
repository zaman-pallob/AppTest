import 'package:apptest/domain/entities/user_data_entity.dart';
import 'package:apptest/domain/repositories/user_repository.dart';

import '../datasources/user_data_sources.dart';

class UserRepoImpl implements UserRepository {
  UserDataSources userDataSources;
  UserRepoImpl(this.userDataSources);

  @override
  Future<UserDataEntity> getUsers({int page = 1, int limit = 10}) async {
    var response = await userDataSources.getUsers(page: page, limit: limit);
    return response;
  }
}
