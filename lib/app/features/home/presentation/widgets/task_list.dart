import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/home/presentation/widgets/new_task_field.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/presentation/tasks_card.dart';

class HomeScreenTaskList extends StatelessWidget {
  const HomeScreenTaskList({super.key, required this.onTaskTap});

  final void Function(String taskId) onTaskTap;

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      if (state.status == TasksStatus.loading) {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state.status == TasksStatus.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Ошибка загрузки задач'),
            backgroundColor: colors.colorRed,
          ),
        );
        return const SizedBox();
      } else {
        final completedTasks =
            state.tasks.where((task) => task.isDone).toList();
        final noCompletedTasks =
            state.tasks.where((task) => !task.isDone).toList();
        final tasks = !state.completedVisible
            ? noCompletedTasks
            : [...noCompletedTasks, ...completedTasks];
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
                    padding: const EdgeInsets.fromLTRB(47, 7, 14, 7),
                    child: const NewTaskField(),
                  );
                } else {
                  return TaskCard(
                    task: tasks[index],
                    onTap: onTaskTap,
                  );
                }
              },
            ),
          ),
        );
      }
    });
  }
}
