import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';

class NewTaskField extends StatefulWidget {
  const NewTaskField({super.key});

  @override
  State<NewTaskField> createState() => _NewTaskFieldState();
}

class _NewTaskFieldState extends State<NewTaskField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addNewTask(BuildContext context) {
    context.read<TasksBloc>().add(AddTask(
        task: Task(
            text: controller.text,
            createdAt: DateTime.now(),
            changedAt: DateTime.now())));
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    return TextField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: AppLocalizations.of(context)!.addNewTaskText,
        hintStyle: text.bodyMedium?.copyWith(color: colors.colorLabelTertiary),
      ),
      style: text.bodyMedium,
      controller: controller,
      onSubmitted: (value) => addNewTask(context),
    );
  }
}
