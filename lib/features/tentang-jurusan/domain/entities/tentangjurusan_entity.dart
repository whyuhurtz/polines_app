class TentangJurusan {
  String? _tentang;
  String? _visi;
  Misi? _misi;

  TentangJurusan({String? tentang, String? visi, Misi? misi}) {
    if (tentang != null) {
      this._tentang = tentang;
    }
    if (visi != null) {
      this._visi = visi;
    }
    if (misi != null) {
      this._misi = misi;
    }
  }

  String? get tentang => _tentang;
  set tentang(String? tentang) => _tentang = tentang;
  String? get visi => _visi;
  set visi(String? visi) => _visi = visi;
  Misi? get misi => _misi;
  set misi(Misi? misi) => _misi = misi;

  TentangJurusan.fromJson(Map<String, dynamic> json) {
    _tentang = json['tentang'];
    _visi = json['visi'];
    _misi = json['misi'] != null ? new Misi.fromJson(json['misi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tentang'] = this._tentang;
    data['visi'] = this._visi;
    if (this._misi != null) {
      data['misi'] = this._misi!.toJson();
    }
    return data;
  }
}

class Misi {
  String? _s1;
  String? _s2;
  String? _s3;
  String? _s4;

  Misi({String? s1, String? s2, String? s3, String? s4}) {
    if (s1 != null) {
      this._s1 = s1;
    }
    if (s2 != null) {
      this._s2 = s2;
    }
    if (s3 != null) {
      this._s3 = s3;
    }
    if (s4 != null) {
      this._s4 = s4;
    }
  }

  String? get s1 => _s1;
  set s1(String? s1) => _s1 = s1;
  String? get s2 => _s2;
  set s2(String? s2) => _s2 = s2;
  String? get s3 => _s3;
  set s3(String? s3) => _s3 = s3;
  String? get s4 => _s4;
  set s4(String? s4) => _s4 = s4;

  Misi.fromJson(Map<String, dynamic> json) {
    _s1 = json['1'];
    _s2 = json['2'];
    _s3 = json['3'];
    _s4 = json['4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this._s1;
    data['2'] = this._s2;
    data['3'] = this._s3;
    data['4'] = this._s4;
    return data;
  }
}