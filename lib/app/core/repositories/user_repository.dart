import 'package:control_data/app/core/model/user_model.dart';

abstract class UserRepository {
  Future<void> createUser(String json);
  Future<User> login(String user);
  Future<User> newUser(String json);
  Future<List<User>> getAllUsers(String json);
  Future<User> updateUser(String json);
  Future<void> deleteUser(String json);
  Future<void> logout(String json);
}
