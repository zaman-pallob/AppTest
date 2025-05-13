import 'package:apptest/core/network/client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future init() async {
  getIt.registerLazySingleton<Dio>(() => Client.createClient());
}
