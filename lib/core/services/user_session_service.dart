import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:axis_crm/entity/user.dart';

class UserSessionService {
  static const String _storageVersion = 'v1';
  static const String _userKey = 'user_$_storageVersion';

  User? _user;

  User? get user => _user;
  String? get userId => _user?.id;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Clear ALL old user keys from previous versions
    final List<String> keys = prefs.getKeys().toList();
    for (final String key in keys) {
      if (key.startsWith('user') && key != _userKey) {
        await prefs.remove(key);
      }
    }

    final String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        final Map<String, dynamic> map = jsonDecode(userJson) as Map<String, dynamic>;
        _user = User.fromJson(map);
      } catch (_) {
        _user = null;
      }
    }
  }

  Future<void> setUser(User user) async {
    _user = user;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<void> clear() async {
    _user = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}