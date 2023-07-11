import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../states/block_tasks/tasks_bloc.dart';
import 'header_visibility_icon_button.dart';

class HomeHeaderTitle extends StatelessWidget {
  const HomeHeaderTitle({
    Key? key,
    required this.shrinkOffset,
    required this.state,
  }) : super(key: key);

  final double shrinkOffset;
  final TasksState state;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final completedTasksCount = BlocProvider.of<TasksBloc>(context)
        .state
        .tasks
        .where((element) => element.isDone)
        .length;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 16 + 44 * shrinkOffset),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              AppLocalizations.of(context)!.appTitle,
              style: text.titleLarge!.copyWith(
                fontSize: 20 + 12 * shrinkOffset,
              ),
            ),
            if (shrinkOffset > 0)
              Padding(
                padding: EdgeInsets.only(top: 6 * shrinkOffset),
                child: Text(
                  AppLocalizations.of(context)!
                      .tasksCompletedCount(completedTasksCount),
                  style: text.bodySmall!.copyWith(
                    color: Theme.of(context).hintColor,
                    fontSize: 16 * shrinkOffset,
                  ),
                ),
              ),
          ],
        ),
        const Spacer(),
        HomeVisibilityIconButton(state: state),
      ],
    );
  }
}
