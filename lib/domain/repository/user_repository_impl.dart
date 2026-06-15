import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/data/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setUser(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }
}