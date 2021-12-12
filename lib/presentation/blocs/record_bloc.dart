import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typing/application/application_service.dart';
import 'package:typing/domain/record_data.dart';

class RecordBloc extends Cubit<List<RecordData>> {
  RecordBloc() : super([]);
  void getAll() async {
    var result = await appService.fetchRecordDataAll();
    emit(result);
  }
}
