
import 'package:carteira/usuario/model/user_model.dart';
import 'package:carteira/usuario/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService {
  final UserPreferences userPreferences;

  UserService({required this.userPreferences});

  Future<List<User>> get users {
    return userPreferences.findAll();
  }

  Future<User> findUserByEmail(String email) async {
    try {
      return await userPreferences.findUserByEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      return await userPreferences.saveUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setLoggedUser(User user) async {
    try {
      return await userPreferences.setLoggedUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<User> get loggedUser {
    return userPreferences.getLoggedUser();
  }

}

@Riverpod(keepAlive: true)
UserService userService(UserServiceRef ref) {
  final prefs = ref.watch(userPreferencesProvider);
  return UserService(userPreferences: prefs);
}
