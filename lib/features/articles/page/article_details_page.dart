import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_articles/app/core/enums.dart';
import 'package:user_articles/app/injection_container.dart';
import 'package:user_articles/domain/models/article_model.dart';
import 'package:user_articles/features/articles/cubit/article_details_cubit.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({
    Key? key,
    required this.id,
    required this.title,
    required this.picture,
    required this.articles,
  }) : super(key: key);

  final ArticleModel id;
  final ArticleModel title;
  final ArticleModel picture;
  final ArticleModel articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(articles.title),
      ),
      body: BlocProvider<ArticleDetailsCubit>(
        create: (context) => getIt()
          ..fetchData(
              articleId: articles.id,
              articleTitle: articles.title,
              articlePicture: articles.picture),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
            ),
            Expanded(
              child: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case Status.initial:
                      return const Center(
                        child: Text('Initial state'),
                      );
                    case Status.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.success:
                      if (state.results.isEmpty) {
                        return const Center(
                          child: Text('No articles found'),
                        );
                      }
                      return ListView(children: [
                        for (final author in state.results)
                          _ArticleItemWidget(
                            model: author,
                          ),
                      ]);
                    case Status.error:
                      return Center(
                        child: Text(
                          state.errorMessage ?? 'Unknown error',
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleItemWidget extends StatelessWidget {
  const _ArticleItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(model.picture),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            color: Colors.black12,
            child: Row(
              children: [
                Expanded(
                  child: Text(model.content),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
