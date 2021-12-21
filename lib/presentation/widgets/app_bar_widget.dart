import 'package:flutter/material.dart';
import 'package:typing/presentation/pages/chart_page.dart';
import 'package:typing/presentation/pages/typing_page.dart';

import '../../constants.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    //メニューの作成
    List<PopupMenuEntry<Object>> mainItems = [];
    var _mainValues = [
      MainMenuItem.top,
      MainMenuItem.chart,
      MainMenuItem.finish,
    ];
    var _mainTexts = [
      AppString.top,
      AppString.chart,
      AppString.finish,
    ];
    var _mainImages = [
      Icons.home,
      Icons.trending_up,
      Icons.logout,
    ];
    for (int i = 0; i < _mainValues.length; i++) {
      mainItems.add(
        PopupMenuItem(
          value: _mainValues[i],
          child: Container(
            child: Row(children: [
              Padding(
                padding: AppPadding.menuIcon,
                child: Container(
                  child: Icon(
                    _mainImages[i],
                    color: Colors.black,
                  ),
                ),
              ),
              Text(_mainTexts[i], style: AppTextStyle.menu),
            ]),
          ),
        ),
      );
      if (i != _mainValues.length - 1)
        mainItems.add(PopupMenuDivider(height: 0));
    }
    return Theme(
      data: Theme.of(context)
          .copyWith(dividerTheme: DividerThemeData(color: Colors.grey)),
      child: AppBar(
        title: Text(
          AppString.appbarTitle,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leadingWidth: kToolbarHeight,
        actions: [
          PopupMenuButton(
            offset: Offset(0, kToolbarHeight),
            icon: Icon(Icons.menu),
            onSelected: (value) async {
              switch (value) {
                case MainMenuItem.top:
                  print('top');
                  Navigator.of(context).pushAndRemoveUntil<dynamic>(
                      TypingPage.route(), (route) => false);
                  break;
                case MainMenuItem.chart:
                  print('scorechart');
                  Navigator.of(context).pushAndRemoveUntil<dynamic>(
                      ChartPage.route(), (route) => false);
                  break;
                case MainMenuItem.finish:
                  print('finish');
                  Navigator.of(context).pushAndRemoveUntil<dynamic>(
                      TypingPage.route(), (route) => false);
                  break;
                default:
              }
            },
            itemBuilder: (context) => mainItems,
          ),
        ],
      ),
    );
  }
}

enum MainMenuItem {
  top,
  chart,
  finish,
}
