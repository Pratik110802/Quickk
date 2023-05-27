import 'package:flutter_test/flutter_test.dart';
import 'package:quickk/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('DatabaseMigrationServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
