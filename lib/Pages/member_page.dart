import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: [
          _topHead(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  Widget _topHead() {
    return Container(
      width: 750.w,
      padding: EdgeInsets.all(20),
      color: Colors.black12,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.h),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://tse1-mm.cn.bing.net/th/id/OIP.fQOMxn6HqmALK37Zs-HPzgHaJi?pid=Api&rs=1'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.h),
            child: Text(
              'promeo',
              style: TextStyle(
                fontSize: 36.sp,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //我的订单标题
  Widget _orderTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.navigate_next_outlined),
      ),
    );
  }

  //订单分类
  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: 750.w,
      height: 150.h,
      padding: EdgeInsets.only(top: 20.h),
      color: Colors.white,
      child: Row(
        children: [
          _orderPice(Icons.payment, '待付款'),
          _orderPice(Icons.query_builder, '待发货'),
          _orderPice(Icons.local_mall, '待收货'),
          _orderPice(Icons.comment, '待评价'),
        ],
      ),
    );
  }

  //订单分类
  Widget _orderPice(IconData icon, String detail) {
    return Container(
      width: 187.w,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(detail),
        ],
      ),
    );
  }

  //通用ListTile
  Widget _myListTile(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.blur_circular_sharp),
        title: Text(title),
        trailing: Icon(Icons.navigate_next_outlined),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}
