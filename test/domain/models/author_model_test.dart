import 'package:flutter_test/flutter_test.dart';
import 'package:user_articles/domain/models/author_model.dart';

void main() {
  test('should getter name return first and second name combined', () {
    // nazwę testu w description wymyślam sobie sama

    //1 PRZYGOTOWANIE
    final model = AuthorModel(1, 'picture', 'Kamil', 'Kowalski');

    //2 WYWOŁANIE
    final result = model.name;

    //3 OCZEKIWANIE
    expect(result, 'Kamil Kowalski');
  });
}
