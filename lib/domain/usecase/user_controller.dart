import 'package:apptest/data/models/user_data_list_response.dart';

import '../repositories/user_repository.dart';

class UserController {
  final UserRepository userRepository;

  UserController(this.userRepository);

  Future<UserDataListResponse?> getUserList(int page, int limit) async {
    var response = await userRepository.getUsers(page: page, limit: limit);
    if (response == null) {
      return UserDataListResponse(
        page: 0,
        perPage: 0,
        total: 0,
        totalPages: 0,
        data: [],
      );
    }
    return response;
  }
}
