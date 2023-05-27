import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceService {
  List<String> urls = [];
  List<String> favs = [];
  List<String> favsseparate = [];
  Future<void> setUrl(String name, String? data) async {
    final pref = await SharedPreferences.getInstance();

    pref.setString(name, data!);
  }

//return list of all the keys present in shredpreference
  Future<List<String>> getallkeys() async {
    final pref = await SharedPreferences.getInstance();

    urls = pref.getKeys().where((element) => element != null).toList();
    log(urls.toString());
    return urls;
  }

//return list of keys that contains fav keyword
  Future<List<String>> getallfavkeys() async {
    final pref = await SharedPreferences.getInstance();
    favs = pref
        .getKeys()
        .where((String key) => key.toLowerCase().contains('❤️'))
        .toList();
    return favs;
  }

  Future<List<String>> separatefav() async {
    String newname;
    final pref = await SharedPreferences.getInstance();

    favsseparate = pref
        .getKeys()
        .where((String key) => key.toLowerCase().contains('fav'))
        .toList();
    for (int i = 1; i < urls.length; i++) {
      if (urls[i].contains('❤️')) {
        newname = urls[i].replaceFirst('❤️ - ', '');

        favsseparate.add(newname);
      } else {
        continue;
      }
    }
    log(favsseparate.toString());
    return favsseparate;
  }

//Delete the Quickk from sharedpreference
  Future<void> deletequickk(String name) async {
    final pref = await SharedPreferences.getInstance();

    pref.remove(name);
  }
}
