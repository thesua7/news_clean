import 'package:floor/floor.dart';
import 'package:news_clean/features/daily_news/data/model/article.dart';

@dao
abstract class ArticleDao {

  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel articleModel);


  @Query('SELECT * FROM article')
  Future<List<ArticleModel>> getArticles();
}
