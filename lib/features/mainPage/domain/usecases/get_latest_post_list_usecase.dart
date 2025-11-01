import 'package:injectable/injectable.dart';

import '../../../../core/data/model/base_response_model.dart';
import '../../../../core/domain/usecase/usecase.dart';
import '../../data/models/post_model.dart';
import '../params/get_post_params.dart';
import '../repository/socials_repository.dart';

@injectable
class GetLatestPostListUseCase
    extends UseCase<Page<PostModel>, GetPostListParams> {
  final SocialsRepository repository;

  GetLatestPostListUseCase(this.repository);

  @override
  Future<Page<PostModel>> call(GetPostListParams params) async {
    return await repository.getLatestPosts(params);
  }
}
