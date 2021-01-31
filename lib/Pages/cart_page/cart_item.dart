import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/cartInfo.dart';
import './cart_count.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;
  CartItem(this.item);
  @override
  Widget build(BuildContext context) {
    // print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
      padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.h,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          _cartCheckBt(context, item),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context),
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(BuildContext context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          context.read<CartProvider>().changeCheckState(item);
        },
      ),
    );
  }

  //商品图片
  Widget _cartImage() {
    return Container(
      width: 150.w,
      // padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName() {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.goodsName),
          CartCount(item),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(BuildContext context) {
    return Container(
      width: 150.w,
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                context.read<CartProvider>().deleteGood(item.goodsId);
              },
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
