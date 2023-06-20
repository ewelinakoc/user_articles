import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

@freezed
class ArticleModel with _$ArticleModel {
 

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory ArticleModel(
    int id,
    String title,
    int authorId,
    String picture,
    String content,
  ) = _ArticleModel; // znika błąd po wygenerowaniu nowego kodu przez freezed

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
