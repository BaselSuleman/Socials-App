import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/comments_model.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/add_post_comment_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/get_post_params.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../domain/params/create_post_params.dart';
import '../../domain/params/toggle_like_params.dart';
import '../../domain/repository/socials_repository.dart';
import '../datasource/socials_remote_datasource.dart';
import '../models/toggle_like_model.dart';

@Singleton(as: SocialsRepository)
class SocialsRepositoryImpl implements SocialsRepository {
  final SocialsRemoteDataSource dataSource;

  SocialsRepositoryImpl(this.dataSource);

  @override
  Future<Page<PostModel>> getLatestPosts(GetPostListParams params) async {
    final res = await dataSource.getLatestPosts(params);
    return res;
  }

  @override
  Future<Page<PostModel>> getUserPosts(GetPostListParams params) async {
    final res = await dataSource.getUserPosts(params);
    return res;
  }

  @override
  Future<bool> addComment(AddPostCommentParams params) async {
    final res = await dataSource.addComment(params);
    return res;
  }

  @override
  Future<Page<CommentModel>> getPostComments(String postId) async {
    final res = await dataSource.getPostComments(postId);
    return res;
  }

  @override
  Future<ToggleLikeModel> toggleLike(ToggleLikeParams params) async {
    final res = await dataSource.toggleLike(params);
    return res;
  }

  @override
  Future<bool> createPost(CreatePostParams params) async {
    final res = await dataSource.createPost(params);
    return res;
  }
}
