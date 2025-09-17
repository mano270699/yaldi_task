import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:yaldi/src/wellcome_page/domain/repository/user_info_repository.dart';
import 'package:yaldi/src/wellcome_page/domain/usecases/user_info_usecase.dart';

import '../../src/login/data/datasources/login_remote_data_source.dart';
import '../../src/login/data/repository/login_reposatory_imp.dart';
import '../../src/login/domain/repository/login_reposatory.dart';
import '../../src/login/domain/usecases/login_usecase.dart';
import '../../src/login/login_view_model.dart';

import '../../src/register/data/datasources/register_remote_data_source.dart';
import '../../src/register/data/repository/register_reposatory_imp.dart';
import '../../src/register/domain/repository/register_reposatory.dart';
import '../../src/register/domain/usecases/register_usecase.dart';

import '../../src/register/register_view_model.dart';
import '../../src/splash_screen/view/splash_screen_view_model.dart';

import '../../src/wellcome_page/data/datasources/user_info_data_sources.dart';
import '../../src/wellcome_page/data/repository/user_info_repository_impl.dart';
import '../../src/wellcome_page/view/user_info_view_model.dart';
import '../common/config.dart';
import '../util/api_interceptor/api_interceptor.dart';

import '../util/network_service.dart';
import 'route_genrator.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: "lib/core/env/.env.prod");

  sl.registerFactory(() => RouteGenerator(routs: sl()));

  sl.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());

  sl.registerLazySingleton(
    () =>
        Dio(BaseOptions(headers: Config.headers))
          ..interceptors.add(ApiInterceptor()),
  );

  /// REPOSITORIES

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImp(dataSource: sl()),
  );
  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImp(dataSource: sl()),
  );
  sl.registerLazySingleton<UserInfoRepository>(
    () => UserInfoRepositoryImp(dataSource: sl()),
  );

  /// USECASES

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => UserInfoUseCase(sl()));

  /// VIEW MODELS
  sl.registerFactory(() => SplashScreenViewModel());
  sl.registerFactory(() => LoginViewModel(loginUseCase: sl()));
  sl.registerFactory(() => RegisterViewModel(registerUseCase: sl()));
  sl.registerFactory(() => UserInfoViewModel(infoUseCase: sl()));

  /// DATA SOURCE

  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<UserInfoRemoteDataSource>(
    () => UserInfoRemoteDataSourceImpl(sl()),
  );
}
