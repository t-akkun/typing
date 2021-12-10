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
  String _pageName = 'メインページ';
  final TextEditingController _typingFormController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Blocの初期化
    _bloc = context.read<TypingBloc>();
    // _bloc.add(TypingEvent.next);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      _bloc.add(TypingEvent.next);
    });
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
                        _pageName,
                        style: AppTextStyle.pageTitle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  BlocBuilder<TypingBloc, QuestionData>(
                    builder: (context, data) => Center(
                      //コンテンツ部分
                      child: Padding(
                        padding: AppPadding.page,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.displayQuestion),
                            TypingFormWidget(controller: _typingFormController),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
