import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/category.dart';
import 'package:flutter_application_1/model/categoryGoodsList.dart';
import 'package:flutter_application_1/provider/category_goods_list.dart';
import 'package:flutter_application_1/provider/child_category.dart';
import 'package:flutter_application_1/service/service_method.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LeftCategoryNav extends StatefulWidget {
  final List<Data> list;
  LeftCategoryNav(this.list);
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  var listIndex = 0;
  @override
  Widget build(BuildContext context) {
    print('全部刷新');
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: widget.list.length,
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
        var childList = widget.list[index].bxMallSubDto;
        var categoryId = widget.list[index].mallCategoryId;
        context.read<ChildCategory>().getChildCategory(childList, categoryId);
        _getGoodsList(categoryId);
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
          widget.list[index].mallCategoryName,
        ),
      ),
    );
  }

  void _getGoodsList(String categoryId) async {
    var data = {'categoryId': categoryId, 'categorySubId': '', 'page': 1};

    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      context.read<CategoryGoodsListProvider>().getGoodsList(goodsList.data);
    });
  }
}
