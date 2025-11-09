// Test de base pour l'application MatchUp

import 'package:flutter_test/flutter_test.dart';

import 'package:matchup/main.dart';

void main() {
  testWidgets('App starts with StartScreen', (WidgetTester tester) async {
    // Lance l'application
    await tester.pumpWidget(const MatchUpApp());

    // Vérifie que l'écran de démarrage s'affiche
    expect(find.text('Trouvez votre match parfait avec l\'IA'), findsOneWidget);
    expect(find.text('Démarrer'), findsOneWidget);
  });
}
