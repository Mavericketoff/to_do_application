import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/bloc_tasks_detail/tasks_detail_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/deadline_text.dart';

class TaskDetailsDeadlineField extends StatefulWidget {
  const TaskDetailsDeadlineField({Key? key, required this.task})
      : super(key: key);

  final Task task;

  @override
  State<TaskDetailsDeadlineField> createState() =>
      _TaskDetailsDeadlineFieldState();
}

class _TaskDetailsDeadlineFieldState extends State<TaskDetailsDeadlineField> {
  late bool switchValue;

  Future<void> pickDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.task.deadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      updateDeadline(selectedDate);
      setState(() {
        switchValue = true;
      });
    }
  }

  void updateDeadline(DateTime newDeadline) {
    context
        .read<TaskDetailsBloc>()
        .add(TaskDetailsUpdateDeadline(deadline: newDeadline));
  }

  void clearDate() {
    context.read<TaskDetailsBloc>().add(const TaskDetailsDeleteDeadline());
    setState(() {
      switchValue = false;
    });
  }

  @override
  void initState() {
    super.initState();
    switchValue = widget.task.deadline != null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        return Row(
          children: [
            GestureDetector(
              onTap: pickDate,
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
                  pickDate();
                } else {
                  clearDate();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
