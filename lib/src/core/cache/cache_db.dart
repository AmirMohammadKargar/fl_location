//? Import required packages and modules
import 'package:fl_location/src/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheDb {
  //? Clear all data stored in SharedPreferences
  Future<void> clearDb(String boxName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Retrieve a boolean value from SharedPreferences
  Future getFromDbBool(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = prefs.getBool(key);
      return res;
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Save a boolean value to SharedPreferences
  Future<void> saveToDbBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Save a string value to SharedPreferences
  Future<void> saveToDbString(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Retrieve a string value from SharedPreferences
  Future getFromDbString(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = prefs.getString(key);
      return res ?? '';
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Save an integer value to SharedPreferences
  Future<void> saveToDbInt(String key, int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Retrieve an integer value from SharedPreferences
  Future getFromDbInt(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var res = prefs.getInt(key);
      return res;
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  //? Delete a value from SharedPreferences
  Future<void> removeFromDb(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } on Exception catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
