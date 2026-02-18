import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:labamu/core/local_storage/shared_preferences/shared_preferences_helper.dart';
import 'package:labamu/core/local_storage/database/database_helper.dart';
import 'package:labamu/core/network/api_client.dart';
import 'package:labamu/core/network/network_info.dart';
import 'package:labamu/core/network/request_interceptor.dart';
import 'package:labamu/features/push_notification/domain/repository/push_notification_repository.dart';
import 'package:labamu/features/push_notification/domain/usecase/push_notification_usecase.dart';
import 'package:labamu/features/push_notification/service/push_notification_service.dart';
import 'package:labamu/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:labamu/features/product/data/datasources/local/product_local_data_source.dart';
import 'package:labamu/features/product/data/datasources/remote/product_remote_data_source.dart';
import 'package:labamu/features/product/data/datasources/product_remote_data_source_impl.dart';
import 'package:labamu/features/product/data/repositories/product_repository_impl.dart';
import 'package:labamu/features/product/domain/repository/product_repository.dart';
import 'package:labamu/features/product/domain/usecase/student_usecase.dart';
import 'package:labamu/features/product/presentation/bloc/product_bloc.dart';
import 'package:labamu/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Step 1: Register SharedPreferences (Async)
  locator.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  // ✅ Step 2: Register SharedPreferencesHelper (Waits for SharedPreferences)
  locator.registerSingletonWithDependencies<SharedPreferencesHelper>(
    () => SharedPreferencesHelper(pref: locator<SharedPreferences>()),
    dependsOn: [SharedPreferences],
  );

  // ✅ Step 3: Register RequestInterceptor (Waits for SharedPreferencesHelper)
  locator.registerSingletonWithDependencies<RequestInterceptor>(
    () => RequestInterceptor(pref: locator<SharedPreferencesHelper>()),
    dependsOn: [SharedPreferencesHelper],
  );

  // ✅ Step 4: Other Core Dependencies
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiClient>(
    () => ApiClient(locator(), locator()),
  );
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(Connectivity()),
  );

  // ✅ Step 5: Bloc Dependencies

  locator.registerFactory(() => ProductBloc(locator(), locator()));

  locator.registerFactory(() => SplashBloc(locator()));
  locator.registerFactory(() => ThemeBloc(locator()));

  // usecase

  locator.registerFactory(() => StudentUsecase(repository: locator()));
  locator.registerFactory(() => PushNotificationUseCase(repository: locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  locator.registerLazySingleton<PushNotificationRepository>(
    () => PushNotificationService(),
  );

  // remote data source
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiClient: locator()),
  );

  // local data source
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(databaseHelper: locator()),
  );

  // ✅ Step 9: Ensure All Dependencies Are Ready
  await locator.allReady();
}
