import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/features/mainPage/domain/params/add_post_comment_params.dart';

import '../../../../core/domain/usecase/usecase.dart';
import '../params/create_post_params.dart';
import '../repository/socials_repository.dart';

@injectable
class CreatePostUseCase extends UseCase<bool, CreatePostParams> {
  final SocialsRepository repository;

  CreatePostUseCase(this.repository);

  @override
  Future<bool> call(CreatePostParams params) async {
    return await repository.createPost(params);
  }
}
