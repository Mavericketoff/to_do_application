part of 'significance_field.dart';

class PopupSignificanceItem extends StatelessWidget {
  const PopupSignificanceItem({required this.significance, super.key});

  final Significance significance;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return significance == Significance.none
        ? Text(
            AppLocalizations.of(context)!.significanceNo,
            style: text.bodyMedium,
          )
        : significance == Significance.lowPriority
            ? Text(
                AppLocalizations.of(context)!.significanceLowPriority,
                style: text.bodyMedium,
              )
            : Text(
                AppLocalizations.of(context)!.significanceHighPriority,
                style: text.bodyMedium?.copyWith(
                  color: colors.colorRed,
                ),
              );
  }
}
