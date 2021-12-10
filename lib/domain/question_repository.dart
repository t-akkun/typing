import 'package:typing/domain/question_data.dart';

abstract class QuestionRepository {
  Future<QuestionData> fetchQuestion();
}
