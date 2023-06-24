import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/bloc_tasks_detail/tasks_detail_bloc.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/deadline_text.dart';

class TaskDetailsDeadlineField extends StatefulWidget {
  const TaskDetailsDeadlineField({super.key});

  @override
  State<TaskDetailsDeadlineField> createState() =>
      _TaskDetailsDeadlineFieldState();
}

class _TaskDetailsDeadlineFieldState extends State<TaskDetailsDeadlineField> {
  bool switchValue = false;

  Future<void> pickDate(BuildContext context, DateTime? deadline) async {
    await showDatePicker(
      context: context,
      initialDate: deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((date) {
      if (date != null) {
        context
            .read<TaskDetailsBloc>()
            .add(TaskDetailsUpdateDeadline(deadline: date));
        setState(() {
          switchValue = true;
        });
      }
    });
  }

  void clearDate(BuildContext context) {
    context.read<TaskDetailsBloc>().add(const TaskDetailsDeleteDeadline());
    setState(() {
      switchValue = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        switchValue = state.currentTask.deadline != null;
        return Row(
          children: [
            GestureDetector(
              onTap: () => pickDate(context, state.currentTask.deadline),
              child: const SizedBox(
                height: 40,
                child: TaskDetailsDeadlineText(),
              ),
            ),
            const Spacer(),
            Switch.adaptive(
              value: switchValue,
              onChanged: (value) {
                if (value) {
                  pickDate(context, state.currentTask.deadline);
                } else {
                  clearDate(context);
                }
              },
            )
          ],
        );
      },
    );
  }
}
