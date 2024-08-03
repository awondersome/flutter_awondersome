import 'package:hive/hive.dart';

enum BoolStorageKeys {
  isFisrtLaunch,
  isNeedLanding,
}

enum MapStorageKeys {
  landingConfig,
}

class StorageService {
  static StorageService? _instance;

  factory StorageService() {
    _instance ??= StorageService._internal();
    return _instance!;
  }

  StorageService._internal();

  Box get box => _box;
  static late Box _box;

  static init() async {
    _box = await Hive.openBox('myBox');
  }

  setBool(BoolStorageKeys key, bool value) {
    _box.put(key.name, value);
  }

  bool getBool(BoolStorageKeys key) {
    return _box.get(key.name, defaultValue: false);
  }

  setMap(MapStorageKeys key, Map value) {
    _box.put(key.name, value);
  }

  Map<String, Object?> getMap(MapStorageKeys key) {
    return _box.get(key.name, defaultValue: {});
  }
}
