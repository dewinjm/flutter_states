flutter format --set-exit-if-changed lib test
flutter analyze --no-current-package lib test/
flutter test --no-pub --coverage $(ls test/*_test.dart)