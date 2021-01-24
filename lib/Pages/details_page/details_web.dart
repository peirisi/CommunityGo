import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails =
        context.watch<DetailsInfoProvide>().goodsInfo.data.goodInfo.goodsDetail;
    bool isLeft = context.watch<DetailsInfoProvide>().isLeft;
    if (isLeft) {
      return Container(
        child: Html(
          data: goodsDetails,
        ),
      );
    } else {
      return Container(
        width: 750.w,
        padding: EdgeInsets.all(10.r),
        child: Text('暂时没有数据'),
        alignment: Alignment.center,
      );
    }
  }
}
