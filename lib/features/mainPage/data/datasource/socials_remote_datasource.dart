import 'package:micropolis_assessment/features/mainPage/data/models/comments_model.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/post_model.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/toggle_like_model.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/create_post_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/toggle_like_params.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../domain/params/add_post_comment_params.dart';
import '../../domain/params/get_post_params.dart';

abstract class SocialsRemoteDataSource {
  Future<Page<PostModel>> getLatestPosts(GetPostListParams params);

  Future<Page<PostModel>> getUserPosts(GetPostListParams params);

  Future<Page<CommentModel>> getPostComments(String postId);

  Future<bool> addComment(AddPostCommentParams params);

  Future<ToggleLikeModel> toggleLike(ToggleLikeParams params);

  Future<bool> createPost(CreatePostParams params);
}
