import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/core/common/logger.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/home/presentation/widgets/new_task_field.dart';
import 'package:to_do_application/features/tasks/block/tasks_bloc.dart';
import 'package:to_do_application/features/tasks/presentation/tasks_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    logger.info(BlocProvider.of<ThemeBloc>(context).state.isDarkTheme);
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      final tasks = !state.completedVisible
          ? state.tasks.where((task) => !task.isDone).toList()
          : state.tasks;
      logger.info('Tasks: $tasks');
      return SliverToBoxAdapter(
        child: Card(
          color: colors.colorBackSecondary,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length + 1,
            itemBuilder: (context, index) {
              if (index == tasks.length) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(52, 7, 14, 7),
                  child: const NewTaskField(),
                );
              } else {
                return TaskCard(
                  task: tasks[index],
                );
              }
            },
          ),
        ),
      );
    });
  }
}
