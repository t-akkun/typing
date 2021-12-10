import 'package:typing/constants.dart';
import 'package:typing/domain/question_data.dart';
import 'package:typing/domain/question_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvQuestionRepository implements QuestionRepository {
  List<QuestionData> _questionData = [];
  List<QuestionData> _shuffleList = [];
  @override
  Future<QuestionData> fetchQuestion() async {
    if (_shuffleList.length <= 0) {
      if (_questionData.length <= 0) {
        var csv = await rootBundle.loadString(AppAsset.questionPath);
        for (String line in csv.split("\r\n")) {
          var rows = line.split(",");
          if (!(rows.length > 0)) continue;
          var data = QuestionData(rows.first, rows[0]);
          _questionData.add(data);
        }
      }
      if (_questionData.length <= 0) {
        print("QuestionLoadError");
        return QuestionData("", "");
      }
      _shuffleList.addAll(_questionData);
      _shuffleList.shuffle();
    }
    QuestionData result = _shuffleList.removeLast();
    return result;
  }
}
