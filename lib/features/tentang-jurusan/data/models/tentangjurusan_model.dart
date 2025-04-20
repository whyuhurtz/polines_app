import 'package:polines_app/features/tentang-jurusan/domain/entities/tentangjurusan_entity.dart';

class TentangJurusanModel extends TentangJurusan {
  TentangJurusanModel({
    String? tentang,
    String? visi,
    Misi? misi,
  }) : super(
          tentang: tentang,
          visi: visi,
          misi: misi,
        );

  factory TentangJurusanModel.fromJson(Map<String, dynamic> json) {
    return TentangJurusanModel(
      tentang: json['tentang'],
      visi: json['visi'],
      misi: json['misi'] != null ? MisiModel.fromJson(json['misi']) : null,
    );
  }
  
  static TentangJurusanModel fromEntity(TentangJurusan entity) {
    return TentangJurusanModel(
      tentang: entity.tentang,
      visi: entity.visi,
      misi: entity.misi,
    );
  }
}

class MisiModel extends Misi {
  MisiModel({
    String? s1,
    String? s2,
    String? s3,
    String? s4,
  }) : super(
          s1: s1,
          s2: s2,
          s3: s3,
          s4: s4,
        );

  factory MisiModel.fromJson(Map<String, dynamic> json) {
    return MisiModel(
      s1: json['1'],
      s2: json['2'],
      s3: json['3'],
      s4: json['4'],
    );
  }
  
  static MisiModel fromEntity(Misi entity) {
    return MisiModel(
      s1: entity.s1,
      s2: entity.s2,
      s3: entity.s3,
      s4: entity.s4,
    );
  }
}