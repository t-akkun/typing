import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typing/application/application_service.dart';
import 'package:typing/domain/question_data.dart';

class TypingBloc extends Cubit<QuestionData> {
  TypingBloc() : super(QuestionData("", ""));
  void getNext() async {
    var result = await appService.fetchQuestion();
    emit(result);
  }
}
