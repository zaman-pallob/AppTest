import 'package:apptest/domain/entities/user_data_entity.dart';

abstract class UserRepository {
  Future<UserDataEntity> getUsers({int page = 1, int limit = 10});
}
