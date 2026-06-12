import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_uz/presentation/home/widgets/owing_status.dart';
import 'package:split_uz/presentation/home/widgets/recent_splits.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Salom, Muhammad',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          CircleAvatar(
            backgroundColor: CupertinoTheme.of(context).primaryColor,
            child: Text('M'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          children: [OwingStatus(), SizedBox(height: 24), RecentSplits()],
        ),
      ),
    );
  }
}
