import 'package:typing/domain/question_data.dart';
import 'package:typing/domain/question_repository.dart';

class ApplicationService {
  final QuestionRepository questionRepository;
  ApplicationService(this.questionRepository);

  Future<QuestionData> fetchQuestion() async {
    return questionRepository.fetchQuestion();
  }
}
