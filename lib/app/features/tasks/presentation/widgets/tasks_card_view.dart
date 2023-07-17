import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/check_box.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/tasks_card_info_btn.dart';
import 'package:to_do_application/app/features/tasks/presentation/widgets/tasks_card_text.dart';

class TaskCardView extends StatelessWidget {
  const TaskCardView({required this.task, super.key, required this.onTap});
  final Task task;

  final void Function(String taskId) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: TaskCheckbox(
              task: task,
              value: task.isDone,
              onChanged: (value) {
                context
                    .read<TasksBloc>()
                    .add(UpdateTask(task: task.copyWith(isDone: !task.isDone)));
              },
            ),
          ),
          Expanded(child: TasksCardText(task: task)),
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: TasksCardInfoButton(task: task, onTap: onTap),
          ),
        ],
      ),
    );
  }
}
