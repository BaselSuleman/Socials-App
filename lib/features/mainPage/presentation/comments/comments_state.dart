part of 'comments_cubit.dart';

enum CommentsStatus { initial, loading, error, success, addLoading }

class CommentsState {
  final CommentsStatus status;
  final Failure? failure;
  final List<CommentModel>? comments;

  CommentsState._({required this.status, this.failure, this.comments});

  CommentsState.initial()
    : status = CommentsStatus.initial,
      failure = null,
      comments = [];

  copyWith({
    CommentsStatus? status,
    Failure? failure,
    List<CommentModel>? comments,
  }) {
    return CommentsState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      comments: comments ?? this.comments,
    );
  }
}
