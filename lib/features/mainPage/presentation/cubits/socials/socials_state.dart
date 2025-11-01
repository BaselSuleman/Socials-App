part of 'socials_cubit.dart';

enum SocialsPageStatus {
  initial,
  loading,
  error,
  success,
  createPostLoading,
  createPostSuccess,
  createPostError,
}

class SocialsPageState {
  final SocialsPageStatus status;
  final Failure? failure;

  SocialsPageState._({required this.status, this.failure});

  SocialsPageState.initial()
    : status = SocialsPageStatus.initial,
      failure = null;

  copyWith({SocialsPageStatus? status, Failure? failure}) {
    return SocialsPageState._(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
