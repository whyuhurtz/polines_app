class News {
  String? _author;
  String? _datePublished;
  String? _timePublished;
  String? _title;
  String? _content;

  News(
      {String? author,
      String? datePublished,
      String? timePublished,
      String? title,
      String? content}) {
    if (author != null) {
      this._author = author;
    }
    if (datePublished != null) {
      this._datePublished = datePublished;
    }
    if (timePublished != null) {
      this._timePublished = timePublished;
    }
    if (title != null) {
      this._title = title;
    }
    if (content != null) {
      this._content = content;
    }
  }

  String? get author => _author;
  set author(String? author) => _author = author;
  String? get datePublished => _datePublished;
  set datePublished(String? datePublished) => _datePublished = datePublished;
  String? get timePublished => _timePublished;
  set timePublished(String? timePublished) => _timePublished = timePublished;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get content => _content;
  set content(String? content) => _content = content;

  News.fromJson(Map<String, dynamic> json) {
    _author = json['author'];
    _datePublished = json['date_published'];
    _timePublished = json['time_published'];
    _title = json['title'];
    _content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this._author;
    data['date_published'] = this._datePublished;
    data['time_published'] = this._timePublished;
    data['title'] = this._title;
    data['content'] = this._content;
    return data;
  }
}