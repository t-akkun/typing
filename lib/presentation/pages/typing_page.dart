import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:typing/presentation/widgets/app_bar_widget.dart';
import 'package:typing/presentation/widgets/text_form_widget.dart';

class TypingPage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => TypingPage(),
    );
  }

  @override
  State<StatefulWidget> createState() => TypingPageState();
}

class TypingPageState extends State<TypingPage> {
  final TextEditingController _typingFormController = TextEditingController();

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
          child: TypingFormWidget(controller: _typingFormController),
        ),
      ),
    );
  }
}
