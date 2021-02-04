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
    // return Container(
    // width: 200.w,
    // margin: EdgeInsets.only(top: 5),
    // decoration: BoxDecoration(
    //   border: Border.all(
    //     width: 1,
    //     color: Colors.black12,
    //   ),
    // ),
    return Row(
      children: [_reduceBtn(context), _goodNmber(item), _increaseBtn(context)],
      // ),
    );
  }

  //减号按钮
  Widget _reduceBtn(BuildContext context) {
    return FlatButton(
      onPressed: () {
        item.count > 1
            ? context.read<CartProvider>().changeCount(item, 'reduce')
            : null;
      },
      height: 45.h,
      minWidth: 45.w,
      padding: EdgeInsets.all(0),
      color: Color(0xFF7fca3e),
      textColor: Colors.white,
      child: Text(
        // item.count > 1 ? '-' : ' ',
        '-',
        style: TextStyle(fontSize: 30.sp),
      ),
    );
  }

  // Widget _reduceBtn(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       context.read<CartProvider>().changeCount(item, 'reduce');
  //     },
  //     child: Container(
  //       width: 45.w,
  //       height: 45.h,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           color: item.count > 1 ? Colors.white : Colors.black12,
  //           border:
  //               Border(right: BorderSide(width: 1.w, color: Colors.black12))),
  //       child: Text(item.count > 1 ? '-' : ' '),
  //     ),
  //   );
  // }

  //加号按钮
  Widget _increaseBtn(BuildContext context) {
    return FlatButton(
      onPressed: () {
        context.read<CartProvider>().changeCount(item, 'add');
      },
      minWidth: 45.w,
      height: 45.h,
      padding: EdgeInsets.all(0),
      color: Color(0xFF7fca3e),
      textColor: Colors.white,
      child: Text('+'),
    );
  }
  //   Widget _increaseBtn(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       context.read<CartProvider>().changeCount(item, 'add');
  //     },
  //     child: Container(
  //       width: 45.w,
  //       height: 45.h,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           border:
  //               Border(left: BorderSide(width: 1.w, color: Colors.black12))),
  //       child: Text('+'),
  //     ),
  //   );
  // }

  //数量显示
  Widget _goodNmber(item) {
    return Container(
      width: 70.w,
      height: 45.h,
      alignment: Alignment.center,
      color: Colors.black12,
      // decoration:
      //     BoxDecoration(border: Border.all(width: 1, color: Colors.black26)),
      child: Text('${item.count}'),
    );
  }
}
