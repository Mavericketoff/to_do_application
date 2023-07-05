import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/bloc_tasks_detail/tasks_detail_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/appbar.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/body.dart';

import '../../../core/common/logger.dart';
import '../../tasks/data/task_model.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen(
      {required this.taskId, required this.isNewTask, super.key});

  final String taskId;
  final bool isNewTask;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void saveTask(BuildContext context) {
    final taskDetailBloc = context.read<TaskDetailsBloc>();
    if (widget.isNewTask) {
      context.read<TasksBloc>().add(AddTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text)));
    } else {
      context.read<TasksBloc>().add(UpdateTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text, changedAt: DateTime.now())));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isNewTask) {
      logger.info('Open task details page to create new task');
    } else {
      logger.info('Open task details page to edit task');
    }

    final task = context.read<TasksBloc>().state.tasks.firstWhere(
        (task) => task.id == widget.taskId,
        orElse: () => Task(
            text: '', createdAt: DateTime.now(), changedAt: DateTime.now()));

    return BlocProvider(
      create: (context) =>
          TaskDetailsBloc(currentTask: task, isNewTask: widget.isNewTask),
      child: BlocBuilder<TaskDetailsBloc, TaskDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TaskDetailsScreenAppBar(saveTask: saveTask),
            body: TaskDetailsScreenBody(
              controller: controller,
            ),
          );
        },
      ),
    );
  }
}
