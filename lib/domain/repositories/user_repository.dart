import 'package:apptest/data/models/user_data_list_response.dart';

abstract class UserRepository {
  Future<UserDataListResponse?> getUsers({int page = 1, int limit = 10});
}
