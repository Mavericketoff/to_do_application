import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/app/features/states/block_tasks/tasks_bloc.dart';

import 'header_title.dart';

class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({
    Key? key,
    required this.shrinkOffset,
  }) : super(key: key);

  final double shrinkOffset;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) => Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: _calculateElevation(shrinkOffset),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 16 + shrinkOffset * 10,
            right: 20 + shrinkOffset * 3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 16 + 26 * shrinkOffset),
              HomeHeaderTitle(shrinkOffset: shrinkOffset, state: state),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateElevation(double shrinkOffset) {
    return shrinkOffset <= 0.05 ? 5 - 100 * shrinkOffset : 0;
  }
}
