import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/favorite/favorite_event.dart';
import 'package:bloc_counter_app/bloc/favorite/favorite_state.dart';
import 'package:bloc_counter_app/model/favorite_model.dart';
import 'package:bloc_counter_app/repository/favorite_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  List<FavoriteModel> favoriteList = [];
  List<FavoriteModel> temFavoriteList = [];
  FavoriteRepository favoriteRepository;
  FavoriteBloc(this.favoriteRepository) : super(FavoriteState()) {
    on<FetchFavoriteList>(fetchList);
    on<FavoriteItem>(_favoriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectedItem);
    on<DeletItem>(_deletItem);
  }

  void fetchList(FetchFavoriteList event, Emitter<FavoriteState> emit) async {
    favoriteList = await favoriteRepository.fetch();
    emit(
      state.copyWith(
        favoriteItemList: favoriteList,
        listStatus: ListStatus.success,
      ),
    );
  }

  void _favoriteItem(FavoriteItem event, Emitter<FavoriteState> emit) {
    // Create a new list with the updated item
    final updatedList =
        state.favoriteItemList.map((item) {
          return item.id == event.item.id
              ? item.copyWith(isFavorite: event.item.isFavorite)
              : item;
        }).toList();

    // Update the temporary favorite list with explicit type
    final List<FavoriteModel> updatedTemFavoriteList = List<FavoriteModel>.from(
      state.temFavoriteItemList,
    );

    emit(
      state.copyWith(
        favoriteItemList: updatedList,
        temFavoriteItemList: updatedTemFavoriteList,
      ),
    );
  }

  void _selectItem(SelectItem event, Emitter<FavoriteState> emit) async {
    temFavoriteList.add(event.item);
    emit(state.copyWith(temFavoriteItemList: List.from(temFavoriteList)));
  }

  void _unSelectedItem(UnSelectItem event, Emitter<FavoriteState> emit) async {
    temFavoriteList.remove(event.item);
    emit(state.copyWith(temFavoriteItemList: List.from(temFavoriteList)));
  }

  void _deletItem(DeletItem event, Emitter<FavoriteState> emit) {
    for (var i = 0; i < temFavoriteList.length; i++) {
      favoriteList.remove(temFavoriteList[i]);
    }
    temFavoriteList.clear();
    emit(
      state.copyWith(
        favoriteItemList: List.from(favoriteList),
        temFavoriteItemList: List.from(temFavoriteList),
      ),
    );
  }
}
