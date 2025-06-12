import 'package:equatable/equatable.dart';

abstract class FetchDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PostFetch extends FetchDataEvent {}

class SearchPost extends FetchDataEvent {
  final String input;
  SearchPost({required this.input});

  @override
  List<Object> get props => [input];
}
