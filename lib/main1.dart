import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _buildVerticalLayout() {
    return VerticalHomePage();
  }

  Widget _buildHorizontalLayout() {
    return HorizontalHomePage();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OrientationBuilder(
      builder: (context, orientation) {
        return MaterialApp(
          home: orientation == Orientation.portrait
              //竖屏布局
              ? _buildVerticalLayout()
              //横屏布局
              : _buildHorizontalLayout(),
          //home: _buildVerticalLayout(),
        );
      },
    );
  }
}

class VerticalHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VerticalHomePageState();
  }
}

class _VerticalHomePageState extends State<VerticalHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance =
        ScreenUtil(width: 1080, height: 2220, allowFontScaling: true)
          ..init(context);
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black,
        width: ScreenUtil().setWidth(400),
        height: ScreenUtil().setHeight(200),
        child: Text(
          "这个是竖屏",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        ),
      ),
    );
  }
}

class HorizontalHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HorizontalHomePage();
  }
}

class _HorizontalHomePage extends State<HorizontalHomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance =
        ScreenUtil(width: 2220, height: 1080, allowFontScaling: true)
          ..init(context);
    return Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: Container(
        alignment: Alignment.center,
        color: Colors.black,
        width: ScreenUtil().setWidth(400),
        height: ScreenUtil().setHeight(200),
        child: Text(
          "这个是横屏",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        ),
      ),
    );
  }
}
