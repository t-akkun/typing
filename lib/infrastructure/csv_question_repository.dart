import 'package:typing/constants.dart';
import 'package:typing/domain/question_data.dart';
import 'package:typing/domain/question_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class CsvQuestionRepository implements QuestionRepository {
  List<QuestionData> _questionData = [];
  List<QuestionData> _shuffleList = [];
  @override
  Future<QuestionData> fetchQuestion() async {
    //問題リストがなければ問題データを追加
    if (_shuffleList.length <= 0) {
      //問題データがなければデータ読み込み
      if (_questionData.length <= 0) {
        var csv = await rootBundle.loadString(AppAsset.questionPath);
        for (String line in csv.split("\r\n")) {
          var rows = line.split(",");
          if (rows.length > 1) {
            var display = rows[1].replaceAll("¥n", "\r\n");
            var data = QuestionData(rows[0], display);
            _questionData.add(data);
          }
        }
      }
      if (_questionData.length <= 0) {
        //問題読み込みエラー
        print("QuestionLoadError");
        return QuestionData("", "");
      }
      _shuffleList.addAll(_questionData);
      _shuffleList.shuffle();
    }
    QuestionData result = _shuffleList.removeLast();
    return result;
  }

  void loadCSV() {}
}
