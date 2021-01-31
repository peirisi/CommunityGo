import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../model/cartInfo.dart';

class CartCount extends StatelessWidget {
  final CartInfoModel item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: [
          _reduceBtn(context),
          _goodNmber(item),
          _increaseBtn(context)
        ],
      ),
    );
  }

  //减号按钮
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CartProvider>().changeCount(item, 'reduce');
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border:
                Border(right: BorderSide(width: 1.w, color: Colors.black12))),
        child: Text(item.count > 1 ? '-' : ' '),
      ),
    );
  }

  //加号按钮
  Widget _increaseBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<CartProvider>().changeCount(item, 'add');
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 1.w, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //数量显示
  Widget _goodNmber(item) {
    return Container(
      width: 70.w,
      height: 45.h,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
