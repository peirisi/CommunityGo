import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:provider/provider.dart';
import '../provider/child_category.dart';
import '../provider/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: [RightCategoryNav(), CategoryGoodsList()],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> list = [];
  var listIndex = 0;
  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = index == listIndex;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        Provider.of<ChildCategory>(context, listen: false)
            .getChildCategory(childList, categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
        list.removeRange(0, 2);
      });
      Provider.of<ChildCategory>(context, listen: false)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) {
    var data = {
      'categoryId':
          categoryId == null ? '2c9f6c946cd22d7b016cd747e4bb0046' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvider>(context, listen: false)
          .getGoodsList(goodsList.data);
    });
  }
}

//小类右侧导航
class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    List list = context.watch<ChildCategory>().childCategoryList;

    return Container(
      height: 80.h,
      width: 570.w,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _rightInkWell(index, list[index]);
        },
      ),
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    int idx = context.read<ChildCategory>().childIndex;
    isClick = index == idx;
    return InkWell(
      onTap: () {
        context.read<ChildCategory>().changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: 28.sp, color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) {
    var data = {
      'categoryId': context.read<ChildCategory>().categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provider.of<CategoryGoodsListProvider>(context, listen: false)
            .getGoodsList([]);
      } else {
        Provider.of<CategoryGoodsListProvider>(context, listen: false)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey _footerKey = GlobalKey();
  var scorllController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    List<CategoryListData> list =
        context.watch<CategoryGoodsListProvider>().goodsList;

    if (scorllController.hasClients &&
        context.watch<ChildCategory>().page == 1) {
      //列表回到顶部
      scorllController.jumpTo(0.0);
    }
    if (list.length > 0) {
      return Expanded(
        child: Container(
            width: 570.w,
            child: EasyRefresh(
              footer: ClassicalFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                infoText: context.watch<ChildCategory>().noMoreText,
                loadedText: '加载完成了',
              ),
              child: ListView.builder(
                controller: scorllController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return _listWidget(list, index);
                },
              ),
              onLoad: () async {
                // print('上拉加载更多');
                _getMoreList();
              },
            )),
      );
    } else {
      return Text('暂时没有数据');
    }
  }

  void _getMoreList() {
    context.read<ChildCategory>().addPage();
    var data = {
      'categoryId': context.read<ChildCategory>().categoryId,
      'categorySubId': context.read<ChildCategory>().subId,
      'page': context.read<ChildCategory>().page,
    };

    request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        context.read<ChildCategory>().changeNoMore('没有更多了');
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.pink,
          textColor: Colors.white,
          fontSize: 30.sp,
        );
      } else {
        Provider.of<CategoryGoodsListProvider>(context, listen: false)
            .getMoreGoodsList(goodsList.data);
      }
    });
  }

  Widget _goodsImage(List<CategoryListData> list, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsName(List<CategoryListData> list, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List<CategoryListData> list, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: [
          Text(
            '价格：￥${list[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List<CategoryListData> list, int index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, '/detail?id=${list[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Row(
          children: [
            _goodsImage(list, index),
            Column(
              children: [_goodsName(list, index), _goodsPrice(list, index)],
            )
          ],
        ),
      ),
    );
  }
}
