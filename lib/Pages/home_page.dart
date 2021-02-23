import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  bool get wantKeepAlive => true;
  GlobalKey _footerKey = GlobalKey();
  bool ok = true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('社区购'),
        ),
        body: FutureBuilder(
          future: loadHomePage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();

              return EasyRefresh(
                footer: ClassicalFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  loadedText: '加载完成了',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiper),
                    TopNavigator(navigatorList),
                    _warpList(),
                  ],
                ),
                onLoad: () async {
                  loadMore();
                },
              );
            } else {
              return Center(
                child: Text('加载中。。。。。。'),
              );
            }
          },
        ));
  }

  Future loadHomePage() async {
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    var response = await request('homePageContext', formData: formData);
    loadMore();
    return response;
  }

  void loadMore() async {
    print('开始加载更多。。。。');
    var formData = {'page': page};
    await request('homePageBelowConten', formData: formData).then((value) {
      var data = jsonDecode(value.toString());
      if (data['data'] == null) {
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.amber[900],
          textColor: Colors.white,
          fontSize: 30.sp,
        );
        return;
      }
      List<Map> newGoodsList = (data['data'] as List).cast();
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
    print('成功加载更多');
  }

  Widget _warpList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: 372.w,
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: [
                Image.network(val['image'], width: 370.w),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF7fca3e),
                    fontSize: 26.sp,
                  ),
                ),
                Text('￥${val['mallPrice']}'),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy(this.swiperDateList);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      height: 333.h,
      child: Swiper(
        itemBuilder: (BuildContext contex, int index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, '/detail?id=${swiperDateList[index]['goodsId']}');
            },
            child: Image.network("${swiperDateList[index]['image']}",
                fit: BoxFit.fill),
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator(this.navigatorList);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: 95.w),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: 310.h,
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
