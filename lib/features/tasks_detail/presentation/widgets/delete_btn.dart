import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/tasks/block/tasks_bloc.dart';
import 'package:to_do_application/features/tasks_detail/bloc/tasks_detail_bloc.dart';

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
      label: Text(AppLocalizations.of(context).delete),
    );
  }
}
