import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/tasks/data/task_enums/significance.dart';

class TasksCardIcon extends StatelessWidget {
  const TasksCardIcon({
    required this.significance,
    super.key,
  });

  final Significance significance;

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: significance == Significance.highPriority
          ? SvgPicture.asset(
              'assets/high_priority.svg',
              colorFilter: ColorFilter.mode(
                colors.colorRed,
                BlendMode.srcIn,
              ),
            )
          : significance == Significance.lowPriority
              ? SvgPicture.asset(
                  'assets/low_priority.svg',
                  colorFilter: ColorFilter.mode(
                    colors.colorLabelTertiary,
                    BlendMode.srcIn,
                  ),
                )
              : SvgPicture.asset(''),
    );
  }
}
