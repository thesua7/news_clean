import 'package:floor/floor.dart';
import 'package:news_clean/features/daily_news/data/data_sources/local/dao/article_dao.dart';
import 'package:news_clean/features/daily_news/data/model/article.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase{

  ArticleDao get articleDao;
  
}