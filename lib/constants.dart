import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppString {
  static const appName = "TypingGame";
  static const title = "タイピング\nゲーム";
  static const start = "スタート";
  static const top = "トップ";
  static const chart = "スコア";
  static const finish = "終了";
  static const retry = "リトライ";
}

class AppTextStyle {
  static final bigButton = TextStyle(fontSize: 20.sp);
  static final title = TextStyle(fontSize: 40.sp);
  static final menu = TextStyle(fontSize: 20.sp);
  static final pageTitle = TextStyle(fontSize: 20.sp);
  static final startCount = TextStyle(fontSize: 40.sp);
}

class AppPadding {
  static final menuIcon = EdgeInsets.all(3.h);
  static final typingForm = EdgeInsets.fromLTRB(50.w, 10.h, 50.w, 10.h);
  static final page = EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 10.h);
  static final text = EdgeInsets.all(10.h);
}

class AppDesign {
  static final smallSpace = 10.h;
}

class AppData {
  static const startCount = 3;
  static const playTime = 3;
}

class AppColor {
  static const background = Color.fromARGB(255, 250, 250, 250);
  static const title = Color.fromARGB(255, 245, 245, 245);
  static const page = Colors.white;
  static const grayout = Colors.grey;
}

class AppAsset {
  static const questionPath = "Assets/QuestionData.csv";
}
