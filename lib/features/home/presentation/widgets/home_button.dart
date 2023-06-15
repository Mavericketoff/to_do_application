import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_application/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/features/tasks/data/task_model.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return FloatingActionButton(
      backgroundColor: colors.colorBlue,
      child: Icon(color: colors.colorWhite, Icons.add),
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/task_details',
          arguments: {'task': Task(text: ''), 'isNew': true},
        );
      },
    );
  }
}
