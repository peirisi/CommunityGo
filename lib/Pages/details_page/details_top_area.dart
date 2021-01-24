import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.watch<DetailsInfoProvide>().goodsInfo == null) {
      return Text('暂时没有数据');
    } else {
      var goodsInfo =
          context.watch<DetailsInfoProvide>().goodsInfo.data.goodInfo;
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            _goodsImage(goodsInfo.image1),
            _goodsName(goodsInfo.goodsName),
            _goodsNumber(goodsInfo.goodsSerialNumber),
            _goodsPrice(goodsInfo.oriPrice, goodsInfo.presentPrice)
          ],
        ),
      );
    }
  }

//商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: 740.w,
    );
  }

//商品名称
  Widget _goodsName(name) {
    return Container(
      width: 740.w,
      padding: EdgeInsets.only(left: 15.w),
      child: Text(
        name,
        style: TextStyle(fontSize: 30.sp),
      ),
    );
  }

//商品编号
  Widget _goodsNumber(number) {
    return Container(
      width: 730.w,
      padding: EdgeInsets.only(left: 15.w),
      margin: EdgeInsets.only(top: 8.h),
      child: Text(
        '编号：$number',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

//商品价格
  Widget _goodsPrice(double oriPrice, double prePrice) {
    return Container(
      padding: EdgeInsets.only(left: 15.w),
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Text(
            '￥$prePrice',
            style: TextStyle(color: Colors.pink, fontSize: 37.sp),
          ),
          Text('市场价：   ', style: TextStyle(fontSize: 27.sp)),
          Text(
            '￥$oriPrice',
            style: TextStyle(
                color: Colors.black12,
                fontSize: 27.sp,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}
