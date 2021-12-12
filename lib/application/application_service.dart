import 'package:typing/domain/question_data.dart';
import 'package:typing/domain/question_repository.dart';
import 'package:typing/domain/record_data.dart';
import 'package:typing/domain/record_data_repository.dart';
import 'package:typing/infrastructure/csv_question_repository.dart';
import 'package:typing/infrastructure/sql_database_repository.dart';

ApplicationService appService =
    ApplicationService(CsvQuestionRepository(), SqlDatabaseRepository.db);

class ApplicationService {
  final QuestionRepository questionRepository;
  final RecordDataRepository recordDataRepository;
  ApplicationService(this.questionRepository, this.recordDataRepository);

  Future<QuestionData> fetchQuestion() async {
    return questionRepository.fetchQuestion();
  }

  Future<int> registerRecordData(RecordData record) async {
    return recordDataRepository.registerRecordData(record);
  }

  Future<List<RecordData>> fetchRecordDataAll() async {
    return await recordDataRepository.fetchRecordDataAll();
  }

  Future<List<RecordData>> fetchRecordDataRange(
      DateTime start, DateTime end) async {
    return await recordDataRepository.fetchRecordDataRange(start, end);
  }

  Future<void> deleteRecordDataAll() async {
    await recordDataRepository.deleteRecordDataAll();
  }
}
