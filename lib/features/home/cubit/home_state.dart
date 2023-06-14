part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default([]) List<AuthorModel> results,
    @Default(Status.initial) Status status,
    String? errorMessage,
  }) = _HomeState;
}





// class HomeState {
//   HomeState({
//     this.results = const [],
//     this.status = Status.initial,
//     this.errorMessage,
//   });

//   final List<AuthorModel> results;
//   final Status status;
//   final String? errorMessage;
// }
