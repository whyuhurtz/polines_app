import 'package:polines_app/features/program-studi/domain/entities/kompetensilulusan_entity.dart';

abstract class KompetensiLulusanRepository {
  Future<KompetensiLulusan> getKompetensiLulusan();
}