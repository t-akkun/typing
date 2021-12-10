import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:typing/presentation/blocs/typing_bloc.dart';
import 'package:typing/presentation/pages/typing_page.dart';

import '../../constants.dart';

class StartPage extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => StartPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var b = context.read<TypingBloc>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppString.title,
                  style: AppTextStyle.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDesign.smallSpace),
                ElevatedButton(
                  child: Text(
                    AppString.start,
                    style: AppTextStyle.bigButton,
                  ),
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil<dynamic>(
                        TypingPage.route(), (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
