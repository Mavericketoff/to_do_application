import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/tasks/block/tasks_bloc.dart';
import 'package:to_do_application/features/tasks/data/task_model.dart';
import 'package:to_do_application/features/tasks/presentation/widgets/tasks_card_view.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, super.key});
  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return Dismissible(
      key: ValueKey(task.id),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            context.read<TasksBloc>().add(DeleteTask(task: task));
            return true;
          case DismissDirection.startToEnd:
            context
                .read<TasksBloc>()
                .add(UpdateTask(task: task.copyWith(isDone: !task.isDone)));
            return false;
          default:
            return false;
        }
      },
      background: ColoredBox(
        color: colors.colorGreen,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Icon(Icons.check, color: colors.colorWhite),
            )
          ],
        ),
      ),
      secondaryBackground: ColoredBox(
        color: colors.colorRed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Icon(Icons.delete, color: colors.colorWhite),
            )
          ],
        ),
      ),
      child: TaskCardView(task: task),
    );
  }
}
