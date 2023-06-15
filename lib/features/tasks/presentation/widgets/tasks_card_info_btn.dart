import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/core/common/logger.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/tasks/data/task_model.dart';

class TasksCardInfoButton extends StatelessWidget {
  const TasksCardInfoButton({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;

    return IconButton(
      icon: const Icon(Icons.info_outline),
      color: colors.colorLabelTertiary,
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/task_details',
          arguments: {'task': task, 'isNew': false},
        );
        logger.info('Open task details page');
      },
    );
  }
}
