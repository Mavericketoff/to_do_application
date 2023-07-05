import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';

class HomeScreenHeader extends SliverPersistentHeaderDelegate {
  const HomeScreenHeader();

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  static const double expandedHeight = 200;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final themeData = Theme.of(context);
    final text = themeData.textTheme;
    const diff = expandedHeight - kToolbarHeight;
    final k = (diff - shrinkOffset) / diff;
    final double percentOfShrinkOffset = k
        .clamp(0, 1)
        .toDouble(); // Применение clamp() и преобразование в double
    final colors = context
        .read<ThemeBloc>()
        .state
        .colorPalette; // Использование context.read для доступа к ThemeBloc
    final tasksBloc = context.read<
        TasksBloc>(); // Использование context.read для доступа к TasksBloc
    final completedTasksCount =
        tasksBloc.state.tasks.where((element) => element.isDone).length;

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Material(
          color: themeData.scaffoldBackgroundColor,
          elevation: percentOfShrinkOffset <= 0.05
              ? 5 - 100 * percentOfShrinkOffset
              : 0,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 16 + percentOfShrinkOffset * 10,
              right: 20 + percentOfShrinkOffset * 3,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 16 + 26 * percentOfShrinkOffset),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 16 + 44 * percentOfShrinkOffset),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appTitle,
                          style: text.titleLarge!.copyWith(
                            fontSize: 20 + 12 * percentOfShrinkOffset,
                          ),
                        ),
                        if (percentOfShrinkOffset > 0)
                          Padding(
                            padding:
                                EdgeInsets.only(top: 6 * percentOfShrinkOffset),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .tasksCompletedCount(completedTasksCount),
                              style: text.bodySmall!.copyWith(
                                color: themeData.hintColor,
                                fontSize: 16 * percentOfShrinkOffset,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          state.completedVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 24,
                          color: colors.colorBlue,
                        ),
                        onPressed: () {
                          tasksBloc
                              .add(const ToggleVisibilityCompletedFilter());
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
