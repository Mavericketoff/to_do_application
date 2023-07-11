import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';

class TasksCardInfoButton extends StatelessWidget {
  const TasksCardInfoButton(
      {required this.task, required this.onTap, super.key});

  final void Function(String taskId) onTap;
  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;

    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: colors.colorLabelTertiary,
      onPressed: () => onTap(task.id),
    );
  }
}
