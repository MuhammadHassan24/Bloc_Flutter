import 'package:bloc_counter_app/model/post_model.dart';
import 'package:bloc_counter_app/utils/enum.dart';
import 'package:equatable/equatable.dart';

class FetchDataState extends Equatable {
  final List<PostModel> postList;
  final List<PostModel> temPostList;
  final PostStatus postStatus;
  final String message;
  final String searchResult;

  const FetchDataState({
    this.postList = const <PostModel>[],
    this.postStatus = PostStatus.loading,
    this.temPostList = const <PostModel>[],
    this.message = '',
    this.searchResult = '',
  });

  FetchDataState copyWith({
    List<PostModel>? postList,
    List<PostModel>? temPostList,
    PostStatus? postStatus,
    String? message,
    String? searchResult,
  }) {
    return FetchDataState(
      postList: postList ?? this.postList,
      postStatus: postStatus ?? this.postStatus,
      message: message ?? this.message,
      searchResult: searchResult ?? this.searchResult,
      temPostList: temPostList ?? this.temPostList,
    );
  }

  @override
  List<Object?> get props => [
    postList,
    postStatus,
    message,
    searchResult,
    temPostList,
  ];
}
