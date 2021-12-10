import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typing/application/application_service.dart';
import 'package:typing/domain/question_data.dart';

enum TypingEvent { next }

class TypingBloc extends Bloc<TypingEvent, QuestionData> {
  final ApplicationService appService;
  TypingBloc(this.appService) : super(QuestionData("", "")) {
    on<TypingEvent>((event, emit) async {
      var result = await appService.fetchQuestion();
      emit(result);
    });
  }
}
