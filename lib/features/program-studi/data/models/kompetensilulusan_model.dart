import 'package:polines_app/features/program-studi/domain/entities/kompetensilulusan_entity.dart';

class KompetensiLulusanModel extends KompetensiLulusan {
  KompetensiLulusanModel({
    List<ProfilLulusan>? profilLulusan,
  }) : super(
          profilLulusan: profilLulusan,
        );

  factory KompetensiLulusanModel.fromJson(Map<String, dynamic> json) {
    return KompetensiLulusanModel(
      profilLulusan: json['profil_lulusan'] != null
          ? List<ProfilLulusan>.from(
              json['profil_lulusan']
                  .map((x) => ProfilLulusan.fromJson(x)),
            )
          : null,
    );
  }

  static KompetensiLulusanModel fromEntity(KompetensiLulusan entity) {
    return KompetensiLulusanModel(
      profilLulusan: entity.profilLulusan,
    );
  }
}