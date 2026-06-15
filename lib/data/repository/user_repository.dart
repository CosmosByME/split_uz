import 'package:split_uz/data/model/user.dart';

abstract class UserRepository {
  Future<UserModel?> getUser(String uid);
  Future<void> setUser(UserModel user);
} 