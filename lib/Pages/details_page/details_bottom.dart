import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import '../../provider/details_info.dart';
import '../../provider/CurentIndex.dart';

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
              InkWell(
                onTap: () {
                  context.read<CurrentIndexProvider>().changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: 110.w,
                  alignment: Alignment.center,
                  child: Icon(
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
          InkWell(
            onTap: () async {
              await context
                  .read<CartProvider>()
                  .save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: 320.w,
              height: 80.h,
              color: Colors.green,
              child: Text(
                '加入购物车',
                style: TextStyle(color: Colors.white, fontSize: 28.sp),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await context.read<CartProvider>().remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: 320.w,
              height: 80.h,
              color: Colors.red,
              child: Text(
                '立即购买',
                style: TextStyle(color: Colors.white, fontSize: 28.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
