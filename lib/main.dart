import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:typing/constants.dart';
import 'package:typing/domain/question_repository.dart';
import 'package:typing/presentation/blocs/typing_bloc.dart';
import 'package:typing/presentation/pages/start_page.dart';
import 'package:typing/presentation/pages/typing_page.dart';

import 'application/application_service.dart';
import 'infrastructure/csv_question_repository.dart';
import 'presentation/blocs/record_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
//縦画面固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        ScreenUtilInit(designSize: Size(450, 800), builder: () => TypingApp()));
  });
}

class TypingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TypingBloc>(
          create: (BuildContext context) => TypingBloc(),
        ),
        BlocProvider<RecordBloc>(
          create: (BuildContext context) => RecordBloc(),
        ),
      ],
      child: MaterialApp(
        title: AppString.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StartPage(),
      ),
    );
  }
}
