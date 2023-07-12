import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_articles/data/remote_data_sources/authors_remote_data_source.dart';
import 'package:user_articles/domain/models/author_model.dart';
import 'package:user_articles/domain/repositories/authors_repository.dart';

class MockAuthorsDataSource extends Mock
    implements AuthorsRemoteRetrofitDataSource {}

void main() {
  late AuthorsRepository sut;
  late MockAuthorsDataSource dataSource;

  setUp(() {
    dataSource = MockAuthorsDataSource();
    sut = AuthorsRepository(remoteDataSource: dataSource);
  });

  group('getAuthorModels', () {
    test('should call remote data source .getAuthors() method', () async {
      //1
      when(() => dataSource.getAuthors()).thenAnswer((_) async => []);
      //2
      await sut.getAuthorModels();
      //3
      verify(() => dataSource.getAuthors()).called(1);
    });
    test('should give list witch names of authors', () async {
      //1
      when(() => dataSource.getAuthors()).thenAnswer(
        (_) async => [
          AuthorModel(1, 'picture', 'Kamil', 'Kowalski'),
          AuthorModel(2, 'picture', 'Jan', 'Borkowski'),
          AuthorModel(4, 'picture', 'Pani', 'Ixińska'),
        ],
      );

      //2
      final results = await sut.getAuthorModels();

      //3
      expect(results, [
        AuthorModel(1, 'picture', 'Kamil', 'Kowalski'),
        AuthorModel(2, 'picture', 'Jan', 'Borkowski'),
        AuthorModel(4, 'picture', 'Pani', 'Ixińska'),
      ]);
    });
  });
}
