import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/features/mainPage/data/datasource/socials_remote_datasource.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/toggle_like_model.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/add_post_comment_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/get_post_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/toggle_like_params.dart';

import '../../../../../core/data/datasource/base_remote_datasource.dart';
import '../../../../core/data/enums/list_key_page_enum.dart';
import '../../../../core/data/model/base_response_model.dart';
import '../../../../core/utils/app_constants.dart';
import '../../domain/params/create_post_params.dart';
import '../models/comments_model.dart';

@Singleton(as: SocialsRemoteDataSource)
class SocialsRemoteDataSourceImpl extends BaseRemoteDataSourceImpl
    implements SocialsRemoteDataSource {
  SocialsRemoteDataSourceImpl({required super.dio});

  String getLatestPostsEndPoint = '${AppConstant.baseUrl}/posts/latest';
  String getUserPostsEndPoint = '${AppConstant.baseUrl}/posts/my';
  String commentsEndPoint = '${AppConstant.baseUrl}/posts/';
  String toggleEndPoint = '${AppConstant.baseUrl}/posts/';
  String createPostEndPoint = '${AppConstant.baseUrl}/posts';

  @override
  Future<Page<PostModel>> getLatestPosts(GetPostListParams params) async {
    final res = await get(
      url: getLatestPostsEndPoint,
      params: params.toJson(),
      decoder: (json) {
        return Page.fromJson(json, PostModel.fromJson, ListKeysPage.posts);
      },
    );
    return res;
  }

  @override
  Future<Page<PostModel>> getUserPosts(GetPostListParams params) async {
    final res = await get(
      url: getUserPostsEndPoint,
      params: params.toJson(),
      decoder: (json) {
        return Page.fromJson(json, PostModel.fromJson, ListKeysPage.posts);
      },
    );
    return res;
  }

  @override
  Future<Page<CommentModel>> getPostComments(String postId) async {
    final res = await get(
      url: "$commentsEndPoint$postId/comments",
      decoder: (json) {
        return Page.fromJson(
          json,
          CommentModel.fromJson,
          ListKeysPage.comments,
        );
      },
    );
    return res;
  }

  @override
  Future<bool> addComment(AddPostCommentParams params) async {
    await post(
      url: "$commentsEndPoint${params.postId}/comments",
      body: params.toJson(),
      decoder: (json) {},
    );
    return true;
  }

  @override
  Future<ToggleLikeModel> toggleLike(ToggleLikeParams params) async {
    final res = await post(
      url: "$toggleEndPoint${params.postId}/like",
      body: params.toJson(),
      decoder: (json) {
        return ToggleLikeModel.fromJson(json);
      },
    );
    return res;
  }

  @override
  Future<bool> createPost(CreatePostParams params) async {
    await post(
      url: createPostEndPoint,
      body: params.toJson(),
      decoder: (json) {},
    );
    return true;
  }
}
