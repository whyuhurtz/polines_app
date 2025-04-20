import 'package:polines_app/features/home/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<List<News>> getNews();
  Future<News> getNewsDetail(String id);
}