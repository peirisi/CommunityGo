import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/category.dart';
import 'package:flutter_application_1/model/categoryGoodsList.dart';
import 'package:flutter_application_1/provider/category_goods_list.dart';
import 'package:flutter_application_1/provider/child_category.dart';
import 'package:flutter_application_1/service/service_method.dart';
import 'category_page/category_goods_list.dart';
import 'category_page/left_category_nav.dart';
import 'category_page/right_category_nav.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: FutureBuilder(
        future: _getCategory(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Row(
                children: <Widget>[
                  LeftCategoryNav(snapshot.data),
                  Column(
                    children: [RightCategoryNav(), CategoryGoodsList()],
                  )
                ],
              ),
            );
          } else {
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _getCategory(BuildContext context) async {
    List<Data> list;
    await request('getCategory').then((value) async {
      var data = json.decode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      list = category.data;
      list.removeRange(0, 2);
      context
          .read<ChildCategory>()
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
    var data = {
      'categoryId': list[0].mallCategoryId,
      'categorySubId': '',
      'page': 1
    };
    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      context.read<CategoryGoodsListProvider>().getGoodsList(goodsList.data);
    });
    print('分类页左侧获取完成');
    return list;
  }
}
