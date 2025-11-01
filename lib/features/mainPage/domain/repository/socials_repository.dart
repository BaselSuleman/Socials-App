import '../../../../core/data/model/base_response_model.dart';
import '../../data/models/comments_model.dart';
import '../../data/models/post_model.dart';
import '../../data/models/toggle_like_model.dart';
import '../params/add_post_comment_params.dart';
import '../params/create_post_params.dart';
import '../params/get_post_params.dart';
import '../params/toggle_like_params.dart';

abstract class SocialsRepository {
  Future<Page<PostModel>> getLatestPosts(GetPostListParams params);

  Future<Page<PostModel>> getUserPosts(GetPostListParams params);

  Future<Page<CommentModel>> getPostComments(String postId);

  Future<bool> addComment(AddPostCommentParams params);

  Future<ToggleLikeModel> toggleLike(ToggleLikeParams params);

  Future<bool> createPost(CreatePostParams params);
}
