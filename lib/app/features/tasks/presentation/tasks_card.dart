import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/tasks_card_view.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({required this.task, Key? key, required this.onTap})
      : super(key: key);

  final Task task;
  final void Function(String taskId) onTap;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return Dismissible(
      key: ValueKey(widget.task.id),
      confirmDismiss: (direction) async {
        switch (direction) {
          case DismissDirection.endToStart:
            context.read<TasksBloc>().add(DeleteTask(task: widget.task));
            return true;
          case DismissDirection.startToEnd:
            context.read<TasksBloc>().add(UpdateTask(
                task: widget.task.copyWith(isDone: !widget.task.isDone)));
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
      child: TaskCardView(
        task: widget.task,
        onTap: widget.onTap,
      ),
    );
  }
}
