import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typing/domain/question_data.dart';
import 'package:typing/presentation/blocs/typing_bloc.dart';
import 'package:typing/presentation/widgets/app_bar_widget.dart';
import 'package:typing/presentation/widgets/text_form_widget.dart';

import '../../constants.dart';

class TypingPage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (context) => TypingPage(),
    );
  }

  @override
  State<TypingPage> createState() => TypingPageState();
}

class TypingPageState extends State<TypingPage> {
  late TypingBloc _bloc;
  String pageName = 'メインページ';
  final TextEditingController _typingFormController = TextEditingController();
  Timer? _timerEvent;
  double _timer = 0;
  int _startCount = 0;
  TypingState _state = TypingState.start;
  QuestionData? _currentQuestion;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    //タイマーイベントの作成
    _timerEvent = Timer.periodic(Duration(milliseconds: 100), (timer) {
      _timer += 0.1;
      setState(() {
        switch (_state) {
          case TypingState.start:
            _startCount = AppData.startCount - _timer.toInt();
            if (_timer > AppData.startCount) {
              _timer = 0;
              _state = TypingState.play;
            }
            break;
          case TypingState.play:
            if (_timer > AppData.playTime) {
              _timer = 0;
              _state = TypingState.finish;
            }
            break;
          default:
            break;
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Blocの初期化
    _bloc = context.read<TypingBloc>();
    _bloc.add(TypingEvent.next);
  }

//回答の送信
  void _sendAnswer() {
    if (_currentQuestion != null) {
      if (_typingFormController.text == _currentQuestion!.typingQuestion) {
        _typingFormController.text = "";
        _score++;
        _bloc.add(TypingEvent.next);
      }
    }
  }

  //データの初期化、リトライ
  void _init() {
    _startCount = 0;
    _state = TypingState.start;
    _bloc.add(TypingEvent.next);
    _timer = 0;
  }

  //コンテンツの作成
  Widget _createContent() {
    Widget _content = Container();
    switch (_state) {
      case TypingState.start:
        _content = Center(
            child:
                Text(_startCount.toString(), style: AppTextStyle.startCount));
        break;
      case TypingState.play:
        if (_currentQuestion != null) {
          _content = Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "残り時間:${(AppData.playTime - _timer).toStringAsFixed(1)}")),
              SizedBox(height: AppDesign.smallSpace),
              Text(_currentQuestion!.displayQuestion,
                  textAlign: TextAlign.center),
              SizedBox(height: AppDesign.smallSpace),
              Text(_currentQuestion!.typingQuestion,
                  textAlign: TextAlign.center),
              SizedBox(height: AppDesign.smallSpace),
              TypingFormWidget(
                  controller: _typingFormController, onPressEnter: _sendAnswer),
            ],
          );
        }
        break;
      case TypingState.finish:
        _content = Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("終了！", textAlign: TextAlign.center),
            SizedBox(height: AppDesign.smallSpace),
            Text("スコア:$_score", textAlign: TextAlign.center),
            SizedBox(height: AppDesign.smallSpace),
            ElevatedButton(
              child: Text(
                AppString.retry,
                style: AppTextStyle.bigButton,
              ),
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                _init();
              },
            ),
          ],
        );
        break;
      default:
    }
    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          /// Android のステータスバーのカラー設定
          statusBarIconBrightness: Brightness.light,

          /// iOSのステータスバーのカラー設定
          statusBarBrightness: Brightness.dark,
        ),
        //戻るボタンの設定
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          //外枠部分
          child: Container(
            color: AppColor.background,
            height: double.infinity,
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.title,
                        border: Border(bottom: BorderSide(width: 0.1))),
                    child: Padding(
                      padding: AppPadding.text,
                      child: Text(
                        pageName,
                        style: AppTextStyle.pageTitle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  BlocBuilder<TypingBloc, QuestionData>(
                    builder: (context, data) {
                      _currentQuestion = data;
                      return Center(
                        child: Padding(
                            padding: AppPadding.page,
                            //コンテンツ部分
                            child: _createContent()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //タイマーイベントの終了
    _timerEvent?.cancel();
  }
}

enum TypingState {
  start,
  play,
  finish,
}
