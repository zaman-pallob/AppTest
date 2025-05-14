import 'package:apptest/domain/entities/user_data_entity.dart';
import '../repositories/user_repository.dart';

class UserController {
  final UserRepository userRepository;

  UserController(this.userRepository);

  Future<UserDataEntity> getUserList(int page, int limit) async {
    var data = await userRepository.getUsers(page: page, limit: limit);
    return data;
  }
}
