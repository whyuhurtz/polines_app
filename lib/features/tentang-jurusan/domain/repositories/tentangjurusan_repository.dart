import 'package:polines_app/features/tentang-jurusan/domain/entities/tentangjurusan_entity.dart';

abstract class TentangJurusanRepository {
  Future<TentangJurusan> getTentangJurusan();
}