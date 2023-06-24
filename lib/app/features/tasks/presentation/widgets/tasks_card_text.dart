import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/tasks_card_tittle.dart';

class TasksCardText extends StatelessWidget {
  const TasksCardText({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TasksCardTitle(task: task),
        if (task.deadline != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              DateFormat.yMMMMd('ru-RU').format(task.deadline!),
              style: text.titleSmall?.copyWith(
                color: colors.colorLabelTertiary,
              ),
            ),
          ),
      ],
    );
  }
}
