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
      width: 180.w,
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
      width: 350.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  '合计:',
                  style: TextStyle(fontSize: 30.sp),
                ),
              ),
              Container(
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
            // width: 390.w,
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkBtn(BuildContext context) {
    return Container(
      width: 200.w,
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () async {
          await context.read<CartProvider>().removeSelect();
        },
        color: Color(0xFF7fca3e),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          '结算(${context.watch<CartProvider>().totalCount})',
          style: TextStyle(
            color: Colors.white,
            // fontSize: 36.sp,
          ),
        ),
      ),
    );
  }
}
