

import 'package:carteira/usuario/model/user_model.dart';
import 'package:carteira/usuario/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {

  @override
  Future<List<User>> build() async {
    return ref.read(userServiceProvider).users;
  }

  Future<bool> saveUser(User user) async{
    final userService = ref.read(userServiceProvider);

    try {
      return await userService.saveUser(user);
      
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<User> findUserByEmail(String email) async {
    final userService = ref.read(userServiceProvider);
    return await userService.findUserByEmail(email);
  }

  Future<bool> signIn(String email, String password) async{
    final userService = ref.read(userServiceProvider);
    final user = await findUserByEmail(email);
    if(user.password == password) {
      userService.setLoggedUser(user);
      return Future.value(true);
    }
    return Future.value(false);
  }
}