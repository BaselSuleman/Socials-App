import 'package:bloc/bloc.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';
import 'package:micropolis_assessment/core/utils/failures/failures.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/create_post_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/get_post_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/toggle_like_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/usecases/create_post_usecase.dart';
import 'package:micropolis_assessment/features/mainPage/domain/usecases/get_user_post_list_usecase.dart';
import 'package:micropolis_assessment/features/mainPage/domain/usecases/toggle_like_usecase.dart';

import '../../../../../../di/injection.dart';
import '../../../../../core/utils/service/pagination_service/pagination_cubit.dart';
import '../../../../../core/utils/service/pagination_service/upload_file_service.dart';
import '../../../data/models/toggle_like_model.dart';
import '../../../domain/usecases/get_latest_post_list_usecase.dart';

part 'socials_state.dart';

class SocialsPageCubit extends Cubit<SocialsPageState> {
  SocialsPageCubit() : super(SocialsPageState.initial()) {
    _getLatestPostListUseCase = getIt<GetLatestPostListUseCase>();
    _getUserPostListUseCase = getIt<GetUserPostListUseCase>();
    _toggleLikeUseCase = getIt<ToggleLikeUseCase>();
    _createPostUseCase = getIt<CreatePostUseCase>();
    _uploadService = getIt<CloudinaryService>();
    getLastestPosts();
    getUserPost();
  }

  late GetLatestPostListUseCase _getLatestPostListUseCase;
  late GetUserPostListUseCase _getUserPostListUseCase;
  late PaginationCubit<PostModel> latestPaginationCubit;
  late PaginationCubit<PostModel> userPaginationCubit;
  late ToggleLikeUseCase _toggleLikeUseCase;
  late CreatePostUseCase _createPostUseCase;
  late CloudinaryService _uploadService;

  Future<void> getLastestPosts({
    String? searchText,
    bool withRefresh = false,
    GetPostListParams? params,
  }) async {
    if (withRefresh) {
      latestPaginationCubit.search();
    }

    latestPaginationCubit = PaginationCubit(
      loadPage: (int currentPage, int maxResult) async {
        GetPostListParams getComplainListParams = GetPostListParams(
          limit: 10,
          page: currentPage,
        );
        var res = await _getLatestPostListUseCase(getComplainListParams);
        return res;
      },
    );
  }

  Future<void> getUserPost({
    String? searchText,
    bool withRefresh = false,
    GetPostListParams? params,
  }) async {
    if (withRefresh) {
      userPaginationCubit.search();
    }

    userPaginationCubit = PaginationCubit(
      loadPage: (int currentPage, int maxResult) async {
        GetPostListParams getComplainListParams = GetPostListParams(
          limit: 10,
          page: currentPage,
          userId: AppConstant.userId,
        );
        var res = await _getUserPostListUseCase(getComplainListParams);
        return res;
      },
    );
  }

  Future<ToggleLikeModel?> toggleLike(ToggleLikeParams params) async {
    try {
      final res = await _toggleLikeUseCase(params);
      return res;
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SocialsPageStatus.error));
    }
    return null;
  }

  Future<bool?> createPost(CreatePostParams params) async {
    emit(state.copyWith(status: SocialsPageStatus.createPostLoading));

    try {
      if ((params.mediaFiles ?? []).isNotEmpty) {
        final mediaFilesCopy = List.of(params.mediaFiles!);

        final uploadedUrls = await Future.wait(
          mediaFilesCopy.map((file) => _uploadService.uploadImage(file)),
        );

        final validUrls = uploadedUrls.whereType<String>().toList();

        params = params.copyWith(
          mediaUrls: [...(params.mediaUrls ?? []), ...validUrls],
        );
      }

      await _createPostUseCase(params);

      emit(state.copyWith(status: SocialsPageStatus.createPostSuccess));
      return true;
    } on Failure catch (failure) {
      emit(
        state.copyWith(
          failure: failure,
          status: SocialsPageStatus.createPostError,
        ),
      );
      return false;
    } catch (e) {
      emit(
        state.copyWith(
          failure: CustomFailure(message: "Something went wrong!"),
          status: SocialsPageStatus.createPostError,
        ),
      );
      return false;
    }
  }
}
