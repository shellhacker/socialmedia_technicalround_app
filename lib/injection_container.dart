import 'package:get_it/get_it.dart';
import 'package:socialmedia_technicalround_app/features/reels/data/reels_repository_impl.dart';
import 'package:socialmedia_technicalround_app/features/reels/domain/repository/reels_repository.dart';

import 'features/reels/application/bloc/reels_bloc.dart';
import 'features/reels/domain/usecase/usecase_page.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio
  // sl.registerSingleton<Dio>(Dio());

  // Data sources
  // sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerLazySingleton<ReelsRepository>(() => ReelsRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => GetReelsCollectionUsecase(sl()));

  // Blocs
  sl.registerFactory(() => ReelsBloc(getReelsCollectionUsecase: sl()));
}
