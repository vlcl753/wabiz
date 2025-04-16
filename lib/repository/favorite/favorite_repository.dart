import 'package:fastcampus_wabiz_client/shared/shared_pref_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_repository.g.dart';

@riverpod
FavoriteRepository favoriteRepository (Ref ref) {
  final pref = ref.watch(sharedPreferencesProvider);
  return  FavoriteRepository(pref);
}

class FavoriteRepository {
  SharedPreferences pref;

  FavoriteRepository(this.pref);

  Future<bool> saveValue(String key, String value) async {
    final result = await pref.setString(key, value);
    return result;
  }

  String? readValue(String key) {
    return pref.getString(key);
  }
}
