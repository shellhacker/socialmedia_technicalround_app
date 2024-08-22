import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia_technicalround_app/features/reels/domain/entities/main_model.dart';

import '../../domain/usecase/usecase_page.dart';

part 'reels_event.dart';
part 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  int count = 0;

  List<Datum> feachedResponse = [];
  bool isLoadingMore = false;

  GetReelsCollectionUsecase getReelsCollectionUsecase;
  ReelsBloc({required this.getReelsCollectionUsecase}) : super(ReelsInitial()) {
    on<GetReels>((event, emit) async {
      count++;
      isLoadingMore = true;

      emit(ReelsLoading());
      final response =
          await getReelsCollectionUsecase.reelsCalling(count.toString());

      if (response is ReelsCompleted) {
        if (response.responseData.isNotEmpty) {
          // print(response.responseData.first.title);
          feachedResponse.addAll(response.responseData);
          isLoadingMore = false;

          print(feachedResponse.length);
        } else {
          // count = 0;
        }
        emit(ReelsCompleted(
            responseData: feachedResponse, isLoadingMore: false, count: count));
        // emit(ReelsCompleted(responseData: feachedResponse));
      } else if (response is ApiErrorResponseModel) {
        emit(ReelsError(error: response.message));
        count = 0;
      }
    });
  }

  scrollListner(context) async {
    final blocProvider = BlocProvider.of<ReelsBloc>(context);

    blocProvider.add(GetReels(request: blocProvider.count.toString()));

    isLoadingMore = false;
  }
}
