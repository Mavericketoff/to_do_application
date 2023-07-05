import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/states/bloc_tasks_detail/tasks_detail_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';

class TaskDetailsDeleteButton extends StatelessWidget {
  const TaskDetailsDeleteButton({required this.isNew, super.key});

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    final taskBloc = context.read<TaskDetailsBloc>();

    return TextButton.icon(
      style: TextButton.styleFrom(
        foregroundColor: isNew ? colors.colorLabelDisable : colors.colorRed,
      ),
      onPressed: isNew
          ? null
          : () {
              context
                  .read<TasksBloc>()
                  .add(DeleteTask(task: taskBloc.state.currentTask));
              Navigator.pop(context);
            },
      icon: const Icon(Icons.delete),
      label: Text(AppLocalizations.of(context)!.delete),
    );
  }
}
