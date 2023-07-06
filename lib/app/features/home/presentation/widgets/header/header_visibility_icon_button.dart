import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../states/block_tasks/tasks_bloc.dart';

class HomeVisibilityIconButton extends StatelessWidget {
  const HomeVisibilityIconButton({Key? key, required this.state})
      : super(key: key);

  final TasksState state;

  @override
  Widget build(BuildContext context) {
    final colors = BlocProvider.of<ThemeBloc>(context).state.colorPalette;
    final tasksBloc = BlocProvider.of<TasksBloc>(context);

    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          state.completedVisible ? Icons.visibility_off : Icons.visibility,
          size: 24,
          color: colors.colorBlue,
        ),
        onPressed: () {
          tasksBloc.add(const ToggleVisibilityCompletedFilter());
        },
      ),
    );
  }
}
