import 'package:apptest/core/network/client.dart';
import 'package:apptest/data/datasources/user_data_sources.dart';
import 'package:apptest/domain/repositories/user_repository.dart';
import 'package:apptest/domain/usecase/user_controller.dart';
import 'package:apptest/presentation/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/user_repo_impl.dart';

GetIt dependency = GetIt.instance;

Future init() async {
  dependency.registerLazySingleton<Dio>(() => Client.createClient());
  dependency.registerLazySingleton(() => UserDataSources(dependency<Dio>()));
  dependency.registerLazySingleton<UserRepository>(
      () => UserRepoImpl(dependency<UserDataSources>()));
  dependency.registerLazySingleton(
    () => UserController(dependency<UserRepository>()),
  );
  dependency.registerFactory<UserProvider>(
      () => UserProvider(dependency<UserController>()));
}
