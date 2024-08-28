import 'dart:convert';
import 'dart:developer';

import 'package:carteira/usuario/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'user_repository.g.dart';

class UserPreferences {

  Future<List<User>> findAll() async {
    final prefs = await SharedPreferences.getInstance();
    final userStringList = prefs.getStringList('users') ?? [];
    return userStringList.map((user) => User.fromJsonString(user)).toList();
  }

  Future<User> findUserByEmail(String email) async {
    final userList = await findAll();
    User userDto = User();
    if(userList.length > 0) {
      userDto = userList.firstWhere((user) => user.mail == email);
    }
    
    log(userDto.toString());
    return userDto;
  }

  Future<bool> saveUser(User user) async {
    final userExists = await findUserByEmail(user.mail ?? "");
    if (userExists.mail == null) {
      final prefs = await SharedPreferences.getInstance();
      var uuid = Uuid();
      user.id = uuid.v4();
      final users = await findAll();
      final userStringList = prefs.getStringList('users') ?? [];
      userStringList.add(json.encode(user.toJson()));
      prefs.setStringList('users', userStringList);
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> setLoggedUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedUser', json.encode(user.toJson()));
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<User> getLoggedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('loggedUser');
    if (userString!= null) {
      return User.fromJsonString(userString);
    }
    return User();
  }

}

@Riverpod(keepAlive: true)
UserPreferences userPreferences(UserPreferencesRef ref) {
  return UserPreferences();
}
