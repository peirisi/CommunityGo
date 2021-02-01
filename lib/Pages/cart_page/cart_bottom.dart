import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Row(
        children: [
          _selectAllBtn(context),
          _allPriceArea(context),
          _checkBtn(context),
        ],
      ),
    );
  }

  Widget _selectAllBtn(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: context.watch<CartProvider>().isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              context.read<CartProvider>().changeAllCheckState(val);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget _allPriceArea(BuildContext context) {
    double totalPrice = context.watch<CartProvider>().totalPrice;
    return Container(
      width: 410.w,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 260.w,
                child: Text(
                  '合计:',
                  style: TextStyle(fontSize: 36.sp),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 150.w,
                child: Text(
                  '￥ ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 30.sp,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 410.w,
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //结算按钮
  Widget _checkBtn(BuildContext context) {
    return Container(
      width: 170.w,
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.r)),
          child: Text(
            '结算(${context.watch<CartProvider>().totalCount})',
            style: TextStyle(
              color: Colors.white,
              // fontSize: 36.sp,
            ),
          ),
        ),
      ),
    );
  }
}
