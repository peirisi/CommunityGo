import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cartInfo.dart';

class CartProvider with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoModel> cartList = [];
  double totalPrice = 0; //总价格
  int totalCount = 0; //总数量
  bool isAllCheck = true; //是否全选

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    for (var item in tempList) {
      if (item['goodsId'] == goodsId) {
        item['count']++;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    }
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    totalCount += count;
    totalPrice += price * count;
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('-----------------清空完成-------------------');
    notifyListeners();
  }

  removeSelect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    List<Map> modifyList = [];
    for (var item in tempList) {
      if (item['isCheck'] == false) {
        modifyList.add(item);
      }
    }
    cartString = json.encode(modifyList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    totalCount = 0;
    totalPrice = 0;
    isAllCheck = true;
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((element) {
        cartList.add(CartInfoModel.fromJson(element));
        if (element['isCheck']) {
          totalCount += element['count'];
          totalPrice += element['price'] * element['count'];
        } else {
          isAllCheck = false;
        }
      });
    }
    notifyListeners();
  }

  //删除购物车商品
  deleteGood(String goodId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == goodId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //切换选中
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //点击全选按钮
  changeAllCheckState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    for (var item in tempList) {
      item['isCheck'] = isCheck;
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //商品数量加减
  changeCount(CartInfoModel cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      ++tempIndex;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
