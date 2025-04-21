class KompetensiLulusan {
  List<ProfilLulusan>? _profilLulusan;

  KompetensiLulusan({List<ProfilLulusan>? profilLulusan}) {
    if (profilLulusan != null) {
      this._profilLulusan = profilLulusan;
    }
  }

  List<ProfilLulusan>? get profilLulusan => _profilLulusan;
  set profilLulusan(List<ProfilLulusan>? profilLulusan) =>
      _profilLulusan = profilLulusan;

  KompetensiLulusan.fromJson(Map<String, dynamic> json) {
    if (json['profil_lulusan'] != null) {
      _profilLulusan = <ProfilLulusan>[];
      json['profil_lulusan'].forEach((v) {
        _profilLulusan!.add(new ProfilLulusan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._profilLulusan != null) {
      data['profil_lulusan'] =
          this._profilLulusan!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfilLulusan {
  String? _title;
  String? _content;

  ProfilLulusan({String? title, String? content}) {
    if (title != null) {
      this._title = title;
    }
    if (content != null) {
      this._content = content;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get content => _content;
  set content(String? content) => _content = content;

  ProfilLulusan.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this._title;
    data['content'] = this._content;
    return data;
  }
}