import 'package:chorale_fva/core/constants/constants.dart';
import 'package:get_storage/get_storage.dart';

abstract class BaseStorage {
  GetStorage? prefs;

  T getValue<T>(String key);

  void setValue<T>(String key, T value);
}

class Storage implements BaseStorage {
  @override
  GetStorage? prefs = GetStorage(Constants.storagePath);

  // @override
  // void onInit() {
  //   prefs = GetStorage(storagePath);
  //   super.onInit();
  // }

  // Began - Singleton
  static final Storage _instance = Storage._internal();
  factory Storage() => _instance;
  Storage._internal();
  // End - Singleton

  @override
  T getValue<T>(String key) => prefs?.read(key);

  @override
  void setValue<T>(String key, T value) async {
    await prefs?.write(key, value);
  }
}