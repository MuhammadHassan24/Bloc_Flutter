import 'package:bloc_counter_app/bloc/favorite/favorite_bloc.dart';
import 'package:bloc_counter_app/bloc/favorite/favorite_event.dart';
import 'package:bloc_counter_app/bloc/favorite/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite App"),
        actions: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return Visibility(
                visible: state.temFavoriteItemList.isNotEmpty ? true : false,
                child: IconButton(
                  onPressed: () {
                    context.read<FavoriteBloc>().add(DeletItem());
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return Center(child: CircularProgressIndicator());
              case ListStatus.faiture:
                return Center(child: Text("Something went wrong"));
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favoriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favoriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value:
                              state.temFavoriteItemList.contains(item)
                                  ? true
                                  : false,
                          onChanged: (value) {
                            if (value!) {
                              context.read<FavoriteBloc>().add(
                                SelectItem(item: item),
                              );
                            } else {
                              context.read<FavoriteBloc>().add(
                                UnSelectItem(item: item),
                              );
                            }
                          },
                        ),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<FavoriteBloc>().add(
                              FavoriteItem(
                                item: item.copyWith(
                                  id: item.id,
                                  value: item.value,
                                  isFavorite: item.isFavorite ? false : true,
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: item.isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
