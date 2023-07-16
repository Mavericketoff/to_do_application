import 'package:flutter/material.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/header/header.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/home_button.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.onTaskTap,
    required this.onNewTaskButtonTap,
    Key? key,
  }) : super(key: key);

  final void Function(String taskId) onTaskTap;
  final void Function() onNewTaskButtonTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPersistentHeader(
              delegate: HomeScreenHeader(),
              pinned: true,
            ),
            HomeScreenTaskList(onTaskTap: onTaskTap),
          ],
        ),
      ),
      floatingActionButton:
          HomeButton(context: context, onNewTaskButtonTap: onNewTaskButtonTap),
    );
  }
}
