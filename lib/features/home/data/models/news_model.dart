import 'package:polines_app/features/home/domain/entities/news_entity.dart';

class NewsModel extends News {
  NewsModel({
    String? author,
    String? datePublished,
    String? timePublished,
    String? title,
    String? content,
  }) : super(
          author: author,
          datePublished: datePublished,
          timePublished: timePublished,
          title: title,
          content: content,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      author: json['author'],
      datePublished: json['date_published'],
      timePublished: json['time_published'],
      title: json['title'],
      content: json['content'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'date_published': datePublished,
      'time_published': timePublished,
      'title': title,
      'content': content,
    };
  }
}