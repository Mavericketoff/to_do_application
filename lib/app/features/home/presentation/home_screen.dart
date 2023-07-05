import 'package:flutter/material.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/header.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/home_button.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: HomeScreenHeader(),
              pinned: true,
            ),
            HomeScreenTaskList(),
          ],
        ),
      ),
      floatingActionButton: HomeButton(context: context),
    );
  }
}
