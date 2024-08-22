import 'package:socialmedia_technicalround_app/features/reels/domain/repository/reels_repository.dart';

class GetReelsCollectionUsecase {
  final ReelsRepository repository;

  GetReelsCollectionUsecase(this.repository);

  reelsCalling(String params) async {
    return await repository.getReelsData(params);
  }
}
