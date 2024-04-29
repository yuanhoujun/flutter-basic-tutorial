import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  UserManager._internal();

  SharedPreferences? _pref;

  static const _userIdKey = "userId";

  Future<String?> get userId async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!.getString(_userIdKey);
  }

  Future<bool> setUserId(String value) async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!.setString(_userIdKey, value);
  }

  Future<bool> get isLogin async {
    String? userId = await this.userId;
    return userId != null;
  }

  Future<bool> clearUserInfo() async {
    _pref ??= await SharedPreferences.getInstance();
    return _pref!.clear();
  }
}
