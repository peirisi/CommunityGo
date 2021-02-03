import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/category.dart';
import 'package:flutter_application_1/model/categoryGoodsList.dart';
import 'package:flutter_application_1/provider/category_goods_list.dart';
import 'package:flutter_application_1/provider/child_category.dart';
import 'package:flutter_application_1/service/service_method.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//右侧导航
class RightCategoryNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List list = context.watch<ChildCategory>().childCategoryList;
    if (list == null) {
      return Text('暂时没有数据');
    } else {
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
            return _rightInkWell(context, index, list[index]);
          },
        ),
      );
    }
  }

  Widget _rightInkWell(BuildContext context, int index, BxMallSubDto item) {
    bool isClick = false;
    int idx = context.read<ChildCategory>().childIndex;
    isClick = index == idx;
    return InkWell(
      onTap: () {
        context.read<ChildCategory>().changeChildIndex(index, item.mallSubId);
        _getGoodsList(context, item.mallSubId);
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

  void _getGoodsList(BuildContext context, String categorySubId) {
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
