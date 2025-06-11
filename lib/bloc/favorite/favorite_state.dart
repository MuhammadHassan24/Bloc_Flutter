import 'package:bloc_counter_app/model/favorite_model.dart';
import 'package:equatable/equatable.dart';

enum ListStatus { loading, success, faiture }

class FavoriteState extends Equatable {
  final List<FavoriteModel> favoriteItemList;
  final List<FavoriteModel> temFavoriteItemList;
  final ListStatus listStatus;

  const FavoriteState({
    this.favoriteItemList = const [],
    this.temFavoriteItemList = const [],
    this.listStatus = ListStatus.loading,
  });

  FavoriteState copyWith({
    List<FavoriteModel>? favoriteItemList,
    ListStatus? listStatus,
    List<FavoriteModel>? temFavoriteItemList,
  }) {
    return FavoriteState(
      favoriteItemList: favoriteItemList ?? this.favoriteItemList,
      temFavoriteItemList: temFavoriteItemList ?? this.temFavoriteItemList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object> get props => [favoriteItemList, temFavoriteItemList];
}
