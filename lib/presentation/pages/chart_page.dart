import 'dart:collection';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:typing/domain/record_data.dart';
import 'package:typing/presentation/blocs/record_bloc.dart';
import 'package:typing/presentation/widgets/app_bar_widget.dart';

import '../../constants.dart';

class ChartPage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (context) => ChartPage(),
    );
  }

  @override
  State<StatefulWidget> createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  String _pageName = 'スコアチャート';
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  late RecordBloc _bloc;
  bool _isInit = false;
  late DateTime _rangeStart;
  late DateTime _rangeEnd;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _isInit = true;
      //Blocイベントの登録
      _bloc = context.read<RecordBloc>();
      _rangeEnd = DateTime.now();
      _rangeStart =
          DateTime(_rangeEnd.year, _rangeEnd.month - 1, _rangeEnd.day);
      if (_rangeEnd.day != _rangeStart.day) {
        _rangeStart = DateTime(_rangeEnd.year, _rangeEnd.month, 0);
      }
      //デフォルトのデータの取得
      _bloc.getAll();
    }
  }

  List<charts.Series<RecordData, int>> _createTimeChartData(
      List<RecordData> data) {
    var series = [
      //スコアデータ
      charts.Series<RecordData, int>(
        id: 'Score',
        strokeWidthPxFn: (_, __) => 2,
        radiusPxFn: (_, __) => 3,
        fillColorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.white),
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
        domainFn: (RecordData data, i) => i!,
        measureFn: (RecordData data, _) {
          return data.score;
        },
        data: data,
      ),
      //ミスタイプデータ
      charts.Series<RecordData, int>(
        id: ' MissType',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (RecordData date, i) => i!,
        measureFn: (RecordData date, _) {
          return date.missType;
        },
        data: data,
      )
        //マルチグラフの設定
        ..setAttribute(charts.rendererIdKey, 'customBar')
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
    return series;
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
                  BlocBuilder<RecordBloc, List<RecordData>>(
                    builder: (context, data) {
                      return Center(
                        child: Padding(
                          padding: AppPadding.page,
                          //コンテンツ部分
                          child: Container(
                            height: 200.h,
                            //グラフ表示
                            child: charts.NumericComboChart(
                              _createTimeChartData(data),
                              animate: true,
                              //スコア
                              defaultRenderer: new charts.LineRendererConfig(
                                  includePoints: true,
                                  symbolRenderer:
                                      charts.CircleSymbolRenderer()),
                              //ミスタイプ
                              secondaryMeasureAxis: charts.NumericAxisSpec(
                                renderSpec: charts.GridlineRendererSpec(
                                    lineStyle: charts.LineStyleSpec(
                                        color: charts.ColorUtil.fromDartColor(
                                            Colors.transparent))),
                              ),
                              customSeriesRenderers: [
                                new charts.BarRendererConfig(
                                    customRendererId: 'customBar')
                              ],
                            ),
                          ),
                        ),
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
}

class ChartData {
  final int num;
  final RecordData data;

  ChartData(this.num, this.data);
}
