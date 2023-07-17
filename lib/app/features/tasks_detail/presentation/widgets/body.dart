import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/bloc_tasks_detail/tasks_detail_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_enums/significance.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/deadline_field.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/delete_btn.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/significance_field.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/text_field.dart';

class TaskDetailsScreenBody extends StatefulWidget {
  const TaskDetailsScreenBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<TaskDetailsScreenBody> createState() => _TaskDetailsScreenBodyState();
}

class _TaskDetailsScreenBodyState extends State<TaskDetailsScreenBody> {
  late Bloc<TaskDetailsEvent, TaskDetailsState> taskBloc;

  @override
  void initState() {
    taskBloc = context.read<TaskDetailsBloc>();
    widget.controller.value =
        TextEditingValue(text: taskBloc.state.currentTask.text);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateSignificanse(Significance significance) {
    taskBloc.add(TaskDetailsUpdateSignificance(significance: significance));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
      builder: (context, state) {
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TaskDetailsTextField(controller: widget.controller),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TaskDetailsSignificanceField(
                selectedSignificance: state.currentTask.significance,
                onSignificanceValueChanged: (significance) =>
                    updateSignificanse(significance),
              ),
            ),
            const Divider(
              indent: 16,
              endIndent: 16,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: TaskDetailsDeadlineField(
                task: state.currentTask,
              ),
            ),
            const Divider(),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TaskDetailsDeleteButton(
                isNew: state.isNewTask,
              ),
            ),
          ],
        );
      },
    );
  }
}
