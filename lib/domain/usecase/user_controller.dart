import 'package:apptest/data/models/user_data_list_response.dart';
import 'package:apptest/domain/entities/user_data_entity.dart';

import '../repositories/user_repository.dart';

class UserController {
  final UserRepository userRepository;

  UserController(this.userRepository);

  Future<UserDataEntity> getUserList(int page, int limit) async {
    var data = await userRepository.getUsers(page: page, limit: limit);
    if (data.isDisconnected == true) {
      return UserDataEntity(
        userDataListResponse: UserDataListResponse(
          page: 0,
          perPage: 0,
          total: 0,
          totalPages: 0,
          data: [],
        ),
        isDisconnected: true,
      );
    }
    return data;
  }
}
