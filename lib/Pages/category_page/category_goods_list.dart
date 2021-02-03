import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/categoryGoodsList.dart';
import 'package:flutter_application_1/provider/category_goods_list.dart';
import 'package:flutter_application_1/provider/child_category.dart';
import 'package:flutter_application_1/routers/application.dart';
import 'package:flutter_application_1/service/service_method.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
    if (list != null) {
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
