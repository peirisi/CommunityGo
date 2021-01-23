import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; //子类高亮索引
  String categoryId = '2c9f6c946cd22d7b016cd74220b70040'; //大类第一页ID
  String subId = ''; //小类ID
  int page = 1; //页数
  String noMoreText = ''; //没有数据时显示的文字
  //大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    String noMoreText = '加载中';
    childIndex = 0;
    categoryId = id;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, String id) {
    page = 1;
    String noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //增加page的方法
  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
  }
}
