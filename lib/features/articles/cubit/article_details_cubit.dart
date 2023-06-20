import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_articles/app/core/enums.dart';
import 'package:user_articles/domain/models/article_model.dart';
import 'package:user_articles/domain/repositories/articles_repository.dart';

part 'article_details_state.dart';
part 'article_details_cubit.freezed.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  ArticleDetailsCubit({required this.articlesRepository}) : super(ArticleDetailsState());

  final ArticlesRepository articlesRepository;

  Future<void> fetchData({required int articleId, required String articlePicture, required String articleTitle}) async {
    emit(
      ArticleDetailsState(
        status: Status.loading,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    try {
      final results = await articlesRepository.getArticleId(articleId);
      emit(
        ArticleDetailsState(
          status: Status.success,
          results: results,
        ),
      );
    } catch (error) {
      emit(
        ArticleDetailsState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
