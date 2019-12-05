import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //默认设置1080x1920
    /*ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    ScreenUtil.instance = ScreenUtil(width: 1920, height: 1080)..init(context);*/

    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance =
        ScreenUtil(width: 1920, height: 1080, allowFontScaling: true)
          ..init(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.yellow,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 1',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 2',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.brown,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.pink,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.deepPurpleAccent,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.cyanAccent,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(200),
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: Text(
                    '使用ScreenUtil 3',
                    style: TextStyle(
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(20)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
