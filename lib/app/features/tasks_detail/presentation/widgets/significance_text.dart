part of 'significance_field.dart';

class SignificanceText extends StatelessWidget {
  const SignificanceText({required this.significance, super.key});

  final Significance significance;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = context.read<ThemeBloc>().state.colorPalette;
    return significance == Significance.none
        ? Text(
            AppLocalizations.of(context).significanceNo,
            style: text.titleSmall?.copyWith(
              color: colors.colorLabelTertiary,
            ),
          )
        : significance == Significance.lowPriority
            ? Text(
                AppLocalizations.of(context).significanceLowPriority,
                style: text.titleSmall,
              )
            : Text(
                AppLocalizations.of(context).significanceHighPriority,
                style: text.titleSmall?.copyWith(
                  color: colors.colorRed,
                ),
              );
  }
}
