import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/features/tasks/block/tasks_bloc.dart';
import 'package:to_do_application/features/tasks_detail/bloc/tasks_detail_bloc.dart';
import 'package:to_do_application/features/tasks_detail/presentation/widgets/appbar.dart';
import 'package:to_do_application/features/tasks_detail/presentation/widgets/body.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController controller = TextEditingController();
  late Map<String, dynamic> navigatorArguments;

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
    if (navigatorArguments['isNew']) {
      context.read<TasksBloc>().add(AddTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text)));
    } else {
      context.read<TasksBloc>().add(UpdateTask(
          task: taskDetailBloc.state.currentTask
              .copyWith(text: controller.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    navigatorArguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) =>
          TaskDetailsBloc(currentTask: navigatorArguments['task']),
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
