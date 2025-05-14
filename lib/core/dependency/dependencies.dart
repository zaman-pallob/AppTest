import 'package:apptest/core/network/client.dart';
import 'package:apptest/data/datasources/local_storage.dart';
import 'package:apptest/data/datasources/user_data_sources.dart';
import 'package:apptest/domain/repositories/user_repository.dart';
import 'package:apptest/domain/usecase/user_controller.dart';
import 'package:apptest/presentation/providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/repositories/user_repo_impl.dart';

GetIt dependency = GetIt.instance;

Future init() async {
  await Hive.initFlutter();
  Box box = await Hive.openBox("user_list");
  dependency.registerLazySingleton(() => LocalStorage(box));
  dependency.registerLazySingleton<Dio>(() => Client.createClient());
  dependency.registerLazySingleton(() => UserDataSources(dependency<Dio>()));
  dependency.registerLazySingleton<UserRepository>(() =>
      UserRepoImpl(dependency<UserDataSources>(), dependency<LocalStorage>()));
  dependency.registerLazySingleton(
    () => UserController(dependency<UserRepository>()),
  );
  dependency.registerFactory<UserProvider>(
      () => UserProvider(dependency<UserController>()));
}
