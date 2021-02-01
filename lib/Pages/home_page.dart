import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey _footerKey = GlobalKey();
  int page = 1;
  List<Map> hotGoodsList = [];
  @override
  bool get wantKeepAlive => true;

  String homePageContent = '正在获取数据';
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        appBar: AppBar(
          title: Text('社区购'),
        ),
        body: FutureBuilder(
          future: request('homePageContext', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                footer: ClassicalFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoColor: Colors.pink,
                  noMoreText: '',
                  infoText: '加载中',
                  loadReadyText: '上拉加载',
                  loadText: 'loadtext是什么',
                  loadingText: '正在加载',
                  loadedText: '加载完成了',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiper),
                    TopNavigator(navigatorList),
                    AdBanner(adPicture),
                    LeaderPhone(leaderImage, leaderPhone),
                    Recommend(recommendList),
                    FloorTitle(floor1Title),
                    FloorContent(floor1),
                    FloorTitle(floor2Title),
                    FloorContent(floor2),
                    FloorTitle(floor3Title),
                    FloorContent(floor3),
                    _hotGoods()
                  ],
                ),
                onLoad: () async {
                  print('开始加载更多。。。。');
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData)
                      .then((value) {
                    var data = jsonDecode(value.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
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

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5.0),
    child: Text('火爆专区'),
  );
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
                  style: TextStyle(color: Colors.pink, fontSize: 26.sp),
                ),
                Row(
                  children: [
                    Text('￥${val['mallPrice']}'),
                    Text('￥${val['price']}',
                        style: TextStyle(
                            color: Colors.black26,
                            decoration: TextDecoration.lineThrough)),
                  ],
                )
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

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: [hotTitle, _warpList()],
      ),
    );
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

//广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;

  const AdBanner(this.adPicture);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  const LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: _launchURL,
      child: Image.network(leaderImage),
    ));
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能进行访问';
    }
  }
}

//推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend(this.recommendList);
//标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.h, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

//商品单独项方法
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, '/detail?id=${recommendList[index]['goodsId']}');
      },
      child: Container(
        height: 330.h,
        width: 250.w,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 1.w, color: Colors.black12)),
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['Price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

// 横向列表
  Widget _recommendList() {
    return Container(
        height: 330.h,
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendList.length,
            itemBuilder: (context, index) {
              return _item(context, index);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;
  const FloorTitle(this.pictureAddress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

//楼层商品
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  const FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

  Widget _firstRow(BuildContext context) {
    return Row(
      children: [
        _goodItem(context, floorGoodsList[0]),
        Column(
          children: [
            _goodItem(context, floorGoodsList[1]),
            _goodItem(context, floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(BuildContext context) {
    return Row(
      children: [
        _goodItem(context, floorGoodsList[3]),
        _goodItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodItem(BuildContext context, Map goods) {
    return Container(
      width: 375.w,
      child: InkWell(
        onTap: () {
          print('点击了楼层商品');
          Application.router
              .navigateTo(context, '/detail?id=${goods['goodsId']}');
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
