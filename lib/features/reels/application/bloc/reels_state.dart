part of 'reels_bloc.dart';

abstract class ReelsState extends Equatable {}

class ReelsInitial extends ReelsState {
  @override
  List<Object?> get props => [];
}

class ReelsLoading extends ReelsState {
  @override
  List<Object?> get props => [];
}

class ReelsCompleted extends ReelsState {
  ReelsCompleted(
      {required this.responseData, this.isLoadingMore = false, this.count = 0});

  final List<Datum> responseData;
  bool isLoadingMore;
  int count;

  @override
  List<Object?> get props => [];
}

class ReelsError extends ReelsState {
  final String error;
  ReelsError({required this.error});

  List<Object?> get props => [];
}
