part of 'reels_bloc.dart';

abstract class ReelsEvent extends Equatable {}

class GetReels extends ReelsEvent {
  final String request;

  GetReels({required this.request});

  @override
  List<Object?> get props => [];
}
