import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TypingPage extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => TypingPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Container(),
        ),
      ),
    );
  }
}
