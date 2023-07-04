import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_enums/significance.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/tasks_card_icon.dart';

class TasksCardTitle extends StatelessWidget {
  const TasksCardTitle({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return RichText(
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          if (task.significance != Significance.none && !task.isDone)
            WidgetSpan(
              child: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: TasksCardIcon(
                  significance: task.significance,
                ),
              ),
            ),
          TextSpan(
            text: task.text,
            style: text.bodyMedium?.copyWith(
              decoration: task.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: task.isDone
                  ? colors.colorLabelTertiary
                  : colors.colorLabelPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
