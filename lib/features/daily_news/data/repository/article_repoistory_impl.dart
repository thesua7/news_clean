import 'dart:io';

import 'package:news_clean/core/constants/constants.dart';
import 'package:news_clean/core/resources/data_state.dart';
import 'package:news_clean/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_clean/features/daily_news/data/model/article.dart';
import 'package:news_clean/features/daily_news/domain/entities/article.dart';
import 'package:news_clean/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';
import 'package:news_clean/features/daily_news/data/data_sources/local/app_database.dart';

class ArticleRepoistoryImpl extends ArticleRepository {

  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepoistoryImpl(this._newsApiService,this._appDatabase);


  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try{
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: apiKEy,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions

            )
        );
      }
    } on DioException catch(e){
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
   return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }



}