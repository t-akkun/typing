import 'package:flutter_bloc/flutter_bloc.dart';

enum TypingEvent { next }

class TypingBloc extends Bloc<TypingEvent, int> {
  TypingBloc() : super(0);

  Stream<int> getNext(TypingEvent event) async* {
    switch (event) {
      case TypingEvent.next:
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
