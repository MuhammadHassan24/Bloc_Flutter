import 'package:bloc_counter_app/model/favorite_model.dart';

class FavoriteRepository {
  Future<List<FavoriteModel>> fetch() async {
    await Future.delayed(Duration(seconds: 3));
    return List.of(_generateList(10));
  }

  List<FavoriteModel> _generateList(int length) {
    return List.generate(
      length,
      (index) => FavoriteModel(id: index.toString(), value: "Item $index"),
    );
  }
}
