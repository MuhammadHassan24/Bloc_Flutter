import 'package:bloc_counter_app/model/favorite_model.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteList extends FavoriteEvent {}

class FavoriteItem extends FavoriteEvent {
  final FavoriteModel item;
  const FavoriteItem({required this.item});
}

class SelectItem extends FavoriteEvent {
  final FavoriteModel item;
  const SelectItem({required this.item});
}

class UnSelectItem extends FavoriteEvent {
  final FavoriteModel item;
  const UnSelectItem({required this.item});
}

class DeletItem extends FavoriteEvent {}
