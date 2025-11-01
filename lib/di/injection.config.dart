// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;
import 'package:micropolis_assessment/core/data/datasource/base_remote_datasource.dart'
    as _i445;
import 'package:micropolis_assessment/core/data/datasource/theme_local_datasource.dart'
    as _i488;
import 'package:micropolis_assessment/core/presentation/blocs/authentication/authentication_cubit.dart'
    as _i1050;

import 'package:micropolis_assessment/core/utils/handler/auth_handler.dart'
    as _i700;
import 'package:micropolis_assessment/core/utils/service/pagination_service/upload_file_service.dart'
    as _i213;
import 'package:micropolis_assessment/di/modules/injectable_module.dart'
    as _i764;
import 'package:micropolis_assessment/features/mainPage/data/datasource/socials_remote_datasource.dart'
    as _i676;
import 'package:micropolis_assessment/features/mainPage/data/datasource/socials_remote_datasource_impl.dart'
    as _i221;
import 'package:micropolis_assessment/features/mainPage/data/repositories/socials_repository_impl.dart'
    as _i92;
import 'package:micropolis_assessment/features/mainPage/domain/repository/socials_repository.dart'
    as _i136;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/add_post_comment_usecase.dart'
    as _i142;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/create_post_usecase.dart'
    as _i970;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/get_latest_post_list_usecase.dart'
    as _i961;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/get_post_comments_usecase.dart'
    as _i1072;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/get_user_post_list_usecase.dart'
    as _i620;
import 'package:micropolis_assessment/features/mainPage/domain/usecases/toggle_like_usecase.dart'
    as _i47;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    gh.singleton<_i700.AuthHandler>(() => _i700.AuthHandler());
    gh.lazySingleton<_i213.CloudinaryService>(() => _i213.CloudinaryService());
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => injectableModule.connectionChecker,
    );
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectableModule.sharedPref,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dioInstance);
    gh.lazySingleton<_i445.BaseRemoteDataSourceImpl>(
      () => _i445.BaseRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i1050.AuthenticationCubit>(
      () => _i1050.AuthenticationCubit(gh<_i700.AuthHandler>()),
    );
    gh.lazySingleton<_i488.ThemeLocalDataSource>(
      () => _i488.ThemeLocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.singleton<_i676.SocialsRemoteDataSource>(
      () => _i221.SocialsRemoteDataSourceImpl(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i136.SocialsRepository>(
      () => _i92.SocialsRepositoryImpl(gh<_i676.SocialsRemoteDataSource>()),
    );
    gh.factory<_i142.AddPostCommentUseCase>(
      () => _i142.AddPostCommentUseCase(gh<_i136.SocialsRepository>()),
    );
    gh.factory<_i970.CreatePostUseCase>(
      () => _i970.CreatePostUseCase(gh<_i136.SocialsRepository>()),
    );
    gh.factory<_i961.GetLatestPostListUseCase>(
      () => _i961.GetLatestPostListUseCase(gh<_i136.SocialsRepository>()),
    );
    gh.factory<_i1072.GetPostCommentsUseCase>(
      () => _i1072.GetPostCommentsUseCase(gh<_i136.SocialsRepository>()),
    );
    gh.factory<_i620.GetUserPostListUseCase>(
      () => _i620.GetUserPostListUseCase(gh<_i136.SocialsRepository>()),
    );
    gh.factory<_i47.ToggleLikeUseCase>(
      () => _i47.ToggleLikeUseCase(gh<_i136.SocialsRepository>()),
    );
    return this;
  }
}

class _$InjectableModule extends _i764.InjectableModule {}
