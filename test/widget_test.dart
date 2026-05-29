import 'package:flutter_test/flutter_test.dart';

import 'package:axis_crm/app.dart';
import 'package:axis_crm/core/di/injection_container.dart';

void main() {
  setUpAll(initDependencies);

  testWidgets('shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Số điện thoại'), findsOneWidget);
    expect(find.text('Tên của bạn'), findsOneWidget);
    expect(find.text('Đăng nhập'), findsOneWidget);
  });
}
