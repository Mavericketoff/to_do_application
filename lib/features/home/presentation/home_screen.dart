import 'package:flutter/material.dart';
import 'package:to_do_application/features/home/presentation/widgets/header.dart';
import 'package:to_do_application/features/home/presentation/widgets/home_button.dart';
import 'package:to_do_application/features/home/presentation/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
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
      floatingActionButton: HomeButton(),
    );
  }
}
