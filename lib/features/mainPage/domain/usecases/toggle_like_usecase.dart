import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecase/usecase.dart';
import '../../data/models/toggle_like_model.dart';
import '../params/toggle_like_params.dart';
import '../repository/socials_repository.dart';

@injectable
class ToggleLikeUseCase extends UseCase<ToggleLikeModel, ToggleLikeParams> {
  final SocialsRepository repository;

  ToggleLikeUseCase(this.repository);

  @override
  Future<ToggleLikeModel> call(ToggleLikeParams params) async {
    return await repository.toggleLike(params);
  }
}
