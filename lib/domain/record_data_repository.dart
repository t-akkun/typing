import 'package:typing/domain/record_data.dart';

abstract class RecordDataRepository {
  Future<int> registerRecordData(RecordData record);
  Future<List<RecordData>> fetchRecordDataAll();
  Future<List<RecordData>> fetchRecordDataRange(DateTime start, DateTime end);
  Future<void> deleteRecordDataAll();
}
