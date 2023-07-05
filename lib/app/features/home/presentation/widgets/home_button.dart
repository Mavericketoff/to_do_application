import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/common/logger.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/core/utils/routes_util.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_model.dart';

class HomeButton extends StatelessWidget {
  final BuildContext context;

  const HomeButton({required this.context, Key? key}) : super(key: key);

  Widget _buildFloatingActionButton({
    required Color backgroundColor,
    required IconData iconData,
    required VoidCallback onPressed,
  }) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      child: Icon(
        iconData,
        color: colors.colorWhite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return Row(
      children: [
        const SizedBox(width: 32),
        _buildFloatingActionButton(
          backgroundColor: colors.colorBlue,
          iconData: Icons.refresh,
          onPressed: () {
            context.read<TasksBloc>().add(const LoadTasks());
          },
        ),
        const Spacer(),
        _buildFloatingActionButton(
          backgroundColor: colors.colorBlue,
          iconData: Icons.add,
          onPressed: () {
            Navigator.pushNamed(
              context,
              RoutesUtil.taskDetailRoute,
              arguments: {
                'task': Task(
                  text: '',
                  createdAt: DateTime.now(),
                  changedAt: DateTime.now(),
                ),
                'isNew': true
              },
            );
            logger.info('Open task details page to create new task');
          },
        ),
      ],
    );
  }
}
