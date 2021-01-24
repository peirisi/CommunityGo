import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLeft = context.watch<DetailsInfoProvide>().isLeft;
    var isRight = context.watch<DetailsInfoProvide>().isRight;
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      child: Row(
        children: [
          _myTabbarLeft(context, isLeft),
          _myTabbarRight(context, isRight),
        ],
      ),
    );
  }

  //左侧
  Widget _myTabbarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        context.read<DetailsInfoProvide>().changeTabbar('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.h,
              color: isLeft ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '详情',
          style: TextStyle(
            color: isLeft ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //右侧
  Widget _myTabbarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        context.read<DetailsInfoProvide>().changeTabbar('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.r),
        alignment: Alignment.center,
        width: 375.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.h,
              color: isRight ? Colors.pink : Colors.black12,
            ),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}
