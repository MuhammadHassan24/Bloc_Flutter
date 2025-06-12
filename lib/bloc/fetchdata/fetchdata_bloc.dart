import 'dart:developer';

import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_event.dart';
import 'package:bloc_counter_app/bloc/fetchdata/fetchdata_state.dart';
import 'package:bloc_counter_app/model/post_model.dart';
import 'package:bloc_counter_app/repository/postfetch_repository.dart';
import 'package:bloc_counter_app/utils/enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  List<PostModel> temPostList = [];
  PostFetchRepository repository = PostFetchRepository();
  FetchDataBloc() : super(const FetchDataState()) {
    on<PostFetch>(fetchPostApi);
    on<SearchPost>(_searchResult);
  }

  void fetchPostApi(PostFetch event, Emitter<FetchDataState> emit) async {
    await repository
        .fetchPost()
        .then((value) {
          log(value.toString());
          emit(state.copyWith(postStatus: PostStatus.success, postList: value));
        })
        .onError((error, stacktrace) {
          log(error.toString());
          log(stacktrace.toString());
          emit(
            state.copyWith(
              postStatus: PostStatus.failure,
              message: error.toString(),
            ),
          );
        });
  }

  void _searchResult(SearchPost event, Emitter<FetchDataState> emit) {
    if (event.input.isEmpty) {
      emit(state.copyWith(temPostList: [], searchResult: ""));
    } else {
      temPostList =
          state.postList
              .where(
                (element) => element.email.toString().toLowerCase().contains(
                  event.input.toLowerCase(),
                ),
              )
              .toList();
      if (temPostList.isEmpty) {
        emit(
          state.copyWith(
            temPostList: temPostList,
            searchResult: "No result Found",
          ),
        );
      } else {
        emit(state.copyWith(temPostList: temPostList, searchResult: ""));
      }
    }
  }
}
