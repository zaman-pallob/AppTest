import 'package:apptest/data/models/user_data_list_response.dart';

class UserDataEntity {
  UserDataListResponse? userDataListResponse;
  bool? isDisconnected;
  UserDataEntity({this.userDataListResponse, this.isDisconnected});
}
