import 'package:flutter_test/flutter_test.dart';
import 'package:hospital_app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HospitalApp());
    expect(find.text('MediCare'), findsNothing); // Splash screen
  });
}
