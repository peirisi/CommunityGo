import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../provider/CurentIndex.dart';
import '../../provider/cart.dart';
import '../../provider/details_info.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = context.watch<DetailsInfoProvide>().goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    return Container(
      width: 750.w,
      color: Colors.white,
      height: 80.h,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w),
                child: IconButton(
                  onPressed: () {
                    context.read<CurrentIndexProvider>().changeIndex(2);
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${context.watch<CartProvider>().totalCount}',
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: 620.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () async {
                    await context
                        .read<CartProvider>()
                        .save(goodsId, goodsName, count, price, images);
                  },
                  minWidth: 280.w,
                  height: 80.h,
                  color: Color(0xFF7fca3e),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
                  child: Text(
                    '加入购物车',
                    style: TextStyle(color: Colors.white, fontSize: 28.sp),
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    await context.read<CartProvider>().remove();
                  },
                  minWidth: 280.w,
                  height: 80.h,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
                  child: Text(
                    '立即购买',
                    style: TextStyle(color: Colors.white, fontSize: 28.sp),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
