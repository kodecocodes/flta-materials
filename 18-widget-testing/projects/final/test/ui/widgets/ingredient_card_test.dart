import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:recipes/ui/widgets/ingredient_card.dart';

Widget _buildWrappedWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: ListView(
        children: [
          child,
        ],
      ),
    ),
  );
}

void main() {
  group('IngredientCard', () {
    testWidgets('can build', (tester) async {
      await tester.pumpWidget(
        _buildWrappedWidget(IngredientCard(
          name: 'colby jack cheese',
          initiallyChecked: false,
          evenRow: true,
          onChecked: (isChecked) {},
        )),
      );

      final cardFinder = find.byType(IngredientCard);
      final titleFinder = find.text('colby jack cheese');

      expect(cardFinder, findsOneWidget);
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('can be checked when tapped', (tester) async {
      var isChecked = false;
      await tester.pumpWidget(
        _buildWrappedWidget(IngredientCard(
          name: 'colby jack cheese',
          initiallyChecked: isChecked,
          evenRow: true,
          onChecked: (newValue) {
            isChecked = newValue;
          },
        )),
      );

      final cardFinder = find.byType(IngredientCard);

      await tester.tap(cardFinder);
      await tester.pumpAndSettle();

      final checkboxFinder = find.byType(Checkbox);

      expect(checkboxFinder, findsOneWidget);
      expect(isChecked, isTrue);
    });
  });

  group('Golden Tests - IngredientCard', () {
    testGoldens('can support light theme', (tester) async {
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario(
            'Light - Unchecked',
            IngredientCard(
              name: 'colby jack cheese',
              initiallyChecked: false,
              evenRow: true,
              onChecked: (newValue) {},
            ))
        ..addScenario(
            'Light - Checked',
            IngredientCard(
              name: 'colby jack cheese',
              initiallyChecked: true,
              evenRow: true,
              onChecked: (newValue) {},
            ));
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
      );
      await screenMatchesGolden(tester, 'light_ingredient_card');
    });

    testGoldens('can support dark theme', (tester) async {
      final builder = GoldenBuilder.grid(columns: 2, widthToHeightRatio: 1)
        ..addScenario(
            'Dark - Unchecked',
            IngredientCard(
              name: 'colby jack cheese',
              initiallyChecked: false,
              evenRow: true,
              onChecked: (newValue) {},
            ))
        ..addScenario(
            'Dark - Checked',
            IngredientCard(
              name: 'colby jack cheese',
              initiallyChecked: true,
              evenRow: true,
              onChecked: (newValue) {},
            ));
      await tester.pumpWidgetBuilder(
        builder.build(),
        wrapper: materialAppWrapper(
          theme: ThemeData.dark(),
        ),
      );
      await screenMatchesGolden(tester, 'dark_ingredient_card');
    });
  });
}
