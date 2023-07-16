import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/app/features/tasks/data/task_enums/significance.dart';
import 'package:to_do_application/app/features/tasks/presentation/tasks_card.dart';
import 'package:to_do_application/app/features/tasks/utils/api/local_storage_util.dart';
import 'package:to_do_application/app/features/tasks_detail/presentation/widgets/significance_field.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Мама, я ломал голову, но так и не понял почему он не находит нужные
  //виджеты, простите...

  testWidgets('Create new task', (widgetTester) async {
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.byKey(const ValueKey('add')));
    await widgetTester.pumpAndSettle();

    await widgetTester.enterText(find.byType(TextField).first, 'New task');
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(TaskDetailsSignificanceField));
    await widgetTester.pumpAndSettle();
    expect(find.byType(PopupMenuItem<Significance>), findsWidgets);

    await widgetTester.tap(find.text('!! Высокий'));
    await widgetTester.pumpAndSettle();
    expect(find.text('!! Высокий'), findsOneWidget);

    await widgetTester.tap(find.byType(Switch));
    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.widgetWithText(TextButton, 'ОК'));
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byKey(const ValueKey('saveBtn')));
    await widgetTester.pumpAndSettle();
    expect(find.text('Список дел'), findsOneWidget);
    expect(find.byType(TaskCard), findsOneWidget);
    expect(find.textContaining('New task', findRichText: true), findsOneWidget);
    expect(find.text(DateFormat.yMMMMd('ru-RU').format(DateTime.now())),
        findsOneWidget);

    final localStorage = LocalStorageUtil();

    final localTasks = await localStorage.getTasks();
    expect(localTasks[0].text, 'New task');
    expect(localTasks[0].significance, Significance.highPriority);
  });
}
