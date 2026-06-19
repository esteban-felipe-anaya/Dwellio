import 'package:dwellio/core/env/env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Env falls back to a default base URL before .env is loaded', () {
    expect(Env.apiBaseUrl, startsWith('http'));
  });

  test('Env reads DWELLIO_API_BASE_URL from the bundled .env', () async {
    await dotenv.load(fileName: Env.fileName);
    expect(dotenv.isInitialized, isTrue);
    expect(Env.apiBaseUrl, startsWith('http'));
    expect(Env.apiBaseUrl, contains(':8000'));
  });
}
