import 'package:flutter_test/flutter_test.dart';
import 'package:quickk/app/app.locator.dart';
import 'package:quickk/ui/views/home/home_viewmodel.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
