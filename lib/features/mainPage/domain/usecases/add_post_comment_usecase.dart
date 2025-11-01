import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/add_post_comment_params.dart';

import '../../../../core/domain/usecase/usecase.dart';
import '../repository/socials_repository.dart';

@injectable
class AddPostCommentUseCase
    extends UseCase<bool, AddPostCommentParams> {
  final SocialsRepository repository;

  AddPostCommentUseCase(this.repository);

  @override
  Future<bool> call(AddPostCommentParams params) async {
    return await repository.addComment(params);
  }
}
