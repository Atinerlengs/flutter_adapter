[toc]
# Flutter 屏幕适配方案
## ppi px in dpi dp 介绍
### ppi (pixels per inch) 
<br>图像分辨率 (在图像中,每英寸所包含的像素数目) 
<br>ppi计算方式: **√（长度像素数² + 宽度像素数²） / 屏幕对角线英寸数**

### px (pixels)
<br>px是画面显示的基本单位,真实的像素并不是点或者方块(虽然有时这样显示),也没有实际固定长度,只是一个抽象的取样。 设计中的像素和实际中显示屏上的像素相对应。
<br>屏幕的分辨率一般就描述为"宽向像素数 x 纵向像素数”,譬如常见分辨率1080x1920,1280x720等。 

### in (inches) 
<br>英寸就是屏幕的物理长度单位, 1英寸 = 2.54厘米,譬如常说手机有5寸、6寸等,这些都是指手机对角线的长度

### dpi (Dots per inch)
<br>每英寸的像素数,即像素密度,120dpi是低密度(ldpi)类型,160dpi是中密度(mdpi),240dpi是高密度(hdpi),320dpi是超高密度(xhdpi), 480dpi是超超高密度(xxhdpi) 

### dp (Density-independent pixels) 
<br>也即dip，设备独立像素，device independent pixels的缩写，Android特有的单位，在屏幕密度dpi = 160屏幕上，1dp = 1px
<br>引入dp的目的：**是为了设计图能适配不同像素密度的屏幕**
<br>
举个栗子吧，如果设计师用像素为单位画图，画了一个4px * 4px的 icon，这样的 icon 放在160dpi和320dpi的两种屏幕上展示，会变成大概这样

![dp图片](https://s2.ax1x.com/2019/12/05/Q3d6SO.jpg)


<br>因此，干脆就不以像素为单位直接画图，而是引入一个新的单位 dp。dp 全称是 “density- independent pixel”，即“密度无关像素”，所以也可以缩写成 dip，不过 dp 更常用。定义dp为 160dpi 时的一个像素大小；那么到 320 dpi 时，它就相当于两个像素。

<br>两者的数值关系如下：

<center> px= dp *（dpi/160）</center>


## ScreenUtil方案适配
### 导入
<br> pubspec.yaml文件里面添加

```
dependencies:
  flutter_screenutil: ^0.5.1
```

### 使用
- 初始化

```
    ScreenUtil.instance =
        ScreenUtil(width: 1920, height: 1080, allowFontScaling: true)
          ..init(context);
```

- 设置宽高和字体

```
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
```

- 案例如图

![1920x1080示例图](https://s2.ax1x.com/2019/12/05/Q34MgH.png)
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1920x1080示例图

![1280x720示例图](https://s2.ax1x.com/2019/12/05/Q342PU.png)
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1280x720示例图

![800x400示例图](https://s2.ax1x.com/2019/12/05/Q344M9.png)
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;800x400示例图

### ScreentUtl适配原理

ScreenUtil适配原理可以看其源码如下：

```
  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  setWidth(double width) => width * scaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(double height) => height * scaleHeight;
```


```
  ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;
```

```
  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }
```


## 横竖屏适配

### 如何解决这个问题
<br>在概念上，解决方法跟Android的方法是类似的。我们也要弄两个布局（这里的布局并不是Android中的布局文件，因为在Flutter中
<br>没有布局文件），一个用于纵向，一个用于横向。然后当设备的方向改变的时候，rebuild更新我们的布局。

### 检测方向变化
<br>Flutter中提供了一个OrientationBuilder的小部件。OrientationBuilder可以在设备的方向发生改变的时候，重新构建布局。

```
/// Builds a widget tree that can depend on the parent widget's orientation
/// (distinct from the device orientation).
///
/// See also:
///
///  * [LayoutBuilder], which exposes the complete constraints, not just the
///    orientation.
///  * [CustomSingleChildLayout], which positions its child during layout.
///  * [CustomMultiChildLayout], with which you can define the precise layout
///    of a list of children during the layout phase.
///  * [MediaQueryData.orientation], which exposes whether the device is in
///    landscape or portrait mode.
class OrientationBuilder extends StatelessWidget {
  /// Creates an orientation builder.
  ///
  /// The [builder] argument must not be null.
  const OrientationBuilder({
    Key key,
    @required this.builder,
  }) : assert(builder != null),
       super(key: key);

  /// Builds the widgets below this widget given this widget's orientation.
  ///
  /// A widget's orientation is simply a factor of its width relative to its
  /// height. For example, a [Column] widget will have a landscape orientation
  /// if its width exceeds its height, even though it displays its children in
  /// a vertical array.
  final OrientationWidgetBuilder builder;

  Widget _buildWithConstraints(BuildContext context, BoxConstraints constraints) {
    // If the constraints are fully unbounded (i.e., maxWidth and maxHeight are
    // both infinite), we prefer Orientation.portrait because its more common to
    // scroll vertically then horizontally.
    final Orientation orientation = constraints.maxWidth > constraints.maxHeight ? Orientation.landscape : Orientation.portrait;
    return builder(context, orientation);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildWithConstraints);
  }
}
```

<br> OrientationBuilder有一个builder函数来构建我们的布局。当设备的方向发生改变的时候，就会调用builder函数。
<br>orientation的值有两个，Orientation.landscape和Orientation.portrait。

### 横竖屏幕案例

- bulid 里面做横竖屏判断
```
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
        );
      },
    );
  }
```

- 竖屏布局

```
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
```

- 横屏布局

```
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
```

![横屏](https://s2.ax1x.com/2019/12/05/Q3hjH0.jpg)
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;horizontal.png
<br> ![竖屏](https://s2.ax1x.com/2019/12/05/Q34iv9.jpg)
<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;vertical.png
