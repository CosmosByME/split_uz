import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:split_uz/data/model/user.dart';
import 'package:split_uz/domain/repository/user_repository_impl.dart';

class HomePage extends StatefulWidget {
  final UserModel? initialUser;
  const HomePage({super.key, this.initialUser});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    if (widget.initialUser != null) {
      _userFuture = Future.value(widget.initialUser);
    } else {
      _userFuture = _loadUser();
    }
  }

  Future<UserModel?> _loadUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return await UserRepositoryImpl().getUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          } else if (!asyncSnapshot.hasData || asyncSnapshot.data == null) {
            return const Center(child: Text("User not found"));
          } else {
            final user = asyncSnapshot.data!;
            return Center(child: Text(user.displayName));
          }
        },
      ),
    );
  }
}
