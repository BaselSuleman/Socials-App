import 'package:bloc/bloc.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/comments_model.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/add_post_comment_params.dart';
import 'package:micropolis_assessment/features/mainPage/domain/usecases/add_post_comment_usecase.dart';
import 'package:micropolis_assessment/features/mainPage/domain/usecases/get_post_comments_usecase.dart';
import '../../../../../../core/utils/failures/base_failure.dart';
import '../../../../di/injection.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit() : super(CommentsState.initial()) {
    _getPostCommentsUseCase = getIt<GetPostCommentsUseCase>();
    _addPostCommentUseCase = getIt<AddPostCommentUseCase>();
  }

  late GetPostCommentsUseCase _getPostCommentsUseCase;
  late AddPostCommentUseCase _addPostCommentUseCase;

  Future<void> getComments(String postId) async {
    emit(state.copyWith(status: CommentsStatus.loading));

    try {
      final res = await _getPostCommentsUseCase(postId);
      emit(state.copyWith(comments: res.list, status: CommentsStatus.success));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: CommentsStatus.error));
    }
  }

  void addComment(CommentModel newComment) async {
    final updatedList = List<CommentModel>.from(state.comments ?? []);
    updatedList.add(newComment);
    emit(
      state.copyWith(comments: updatedList, status: CommentsStatus.addLoading),
    );
    try {
      await _addPostCommentUseCase(
        AddPostCommentParams(
          postId: newComment.postId ?? "",
          content: newComment.content,
          userId: AppConstant.userId,
        ),
      );
      emit(
        state.copyWith(comments: updatedList, status: CommentsStatus.success),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: CommentsStatus.error));
    }
    emit(state.copyWith(comments: updatedList));
  }
}
