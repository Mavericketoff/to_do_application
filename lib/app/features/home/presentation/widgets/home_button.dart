import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';

class HomeButton extends StatelessWidget {
  final BuildContext context;

  const HomeButton(
      {required this.onNewTaskButtonTap, super.key, required this.context});

  final void Function() onNewTaskButtonTap;
  Widget _buildFloatingActionButton({
    required Color backgroundColor,
    required IconData iconData,
    required VoidCallback onPressed,
    required String id,
    required ValueKey<String> key,
  }) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    if (id == 'Refresh') {
      return FloatingActionButton(
        key: const ValueKey('ref'),
        heroTag: 'RefreshButton',
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        child: Icon(
          iconData,
          color: colors.colorWhite,
        ),
      );
    } else {
      return FloatingActionButton(
        key: const ValueKey('add'),
        heroTag: 'AddButton',
        onPressed: onPressed,
        backgroundColor: backgroundColor,
        child: Icon(
          iconData,
          color: colors.colorWhite,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return Row(
      children: [
        const SizedBox(width: 32),
        _buildFloatingActionButton(
          key: const ValueKey('ref'),
          id: 'Refresh',
          backgroundColor: colors.colorBlue,
          iconData: Icons.refresh,
          onPressed: () {
            context.read<TasksBloc>().add(const LoadTasks());
          },
        ),
        const Spacer(),
        _buildFloatingActionButton(
          key: const ValueKey('add'),
          id: 'add',
          backgroundColor: colors.colorBlue,
          iconData: Icons.add,
          onPressed: onNewTaskButtonTap,
        ),
      ],
    );
  }
}
