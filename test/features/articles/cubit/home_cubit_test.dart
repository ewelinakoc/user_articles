import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:user_articles/app/core/enums.dart';
import 'package:user_articles/domain/models/author_model.dart';
import 'package:user_articles/domain/repositories/authors_repository.dart';
import 'package:user_articles/features/home/cubit/home_cubit.dart';

class MockAuthorsRepository extends Mock implements AuthorsRepository {}

void main() {
  late HomeCubit sut;
  late MockAuthorsRepository repository;

  setUp(
    () => {
      repository = MockAuthorsRepository(),
      sut = HomeCubit(authorsRepository: repository),
    },
  );

  group(
    'start',
    () {
      group('success', () {});
      setUp(
        () {
          when(() => repository.getAuthorModels()).thenAnswer(
            (_) async => [
              AuthorModel(1, 'picture', 'Kamil', 'Kowalski'),
              AuthorModel(2, 'picture', 'Jan', 'Borkowski'),
              AuthorModel(4, 'picture', 'Pani', 'Ixińska'),
            ],
          );
        },
      );

      blocTest(
        'emits Status.loading then status.success with results',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          HomeState(
            status: Status.loading,
          ),
          HomeState(
            status: Status.success,
            results: [
              AuthorModel(1, 'picture', 'Kamil', 'Kowalski'),
              AuthorModel(2, 'picture', 'Jan', 'Borkowski'),
              AuthorModel(4, 'picture', 'Pani', 'Ixińska'),
            ],
          ),
        ],
      );

      group(
        'failure',
        () {
          setUp(() {
              when(() => repository.getAuthorModels()).thenThrow(
                Exception('test-exception-error'),
              );
            },
          );
          blocTest(
            'emits status.loading then status.error with error message',
            build: () => sut,
            act: (cubit) => cubit.start(),
            expect: () => [
              HomeState(
                status: Status.loading,
              ),
              HomeState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error')
            ],
          );
        },
      );
    },
  );
}
