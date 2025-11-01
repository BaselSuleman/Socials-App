import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/features/mainPage/data/models/comments_model.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../../../core/domain/usecase/usecase.dart';
import '../repository/socials_repository.dart';

@injectable
class GetPostCommentsUseCase extends UseCase<Page<CommentModel>, String> {
  final SocialsRepository repository;

  GetPostCommentsUseCase(this.repository);

  @override
  Future<Page<CommentModel>> call(String params) async {
    return await repository.getPostComments(params);
  }
}
