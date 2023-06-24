import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/app/core/theme/bloc/theme_bloc.dart';
import 'package:to_do_application/app/features/tasks/data/task_enums/significance.dart';

part 'popup_significance_item.dart';
part 'significance_text.dart';

class TaskDetailsSignificanceField extends StatelessWidget {
  const TaskDetailsSignificanceField({
    required this.selectedSignificance,
    required this.onSignificanceValueChanged,
    super.key,
  });

  final Significance selectedSignificance;
  final void Function(Significance significance) onSignificanceValueChanged;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return PopupMenuButton<Significance>(
      initialValue: selectedSignificance,
      itemBuilder: (context) => <PopupMenuEntry<Significance>>[
        for (var significance in Significance.values)
          PopupMenuItem<Significance>(
            value: significance,
            child: PopupSignificanceItem(significance: significance),
          ),
      ],
      onSelected: onSignificanceValueChanged,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).significance,
            style: text.bodyMedium,
          ),
          SignificanceText(significance: selectedSignificance)
        ],
      ),
    );
  }
}
