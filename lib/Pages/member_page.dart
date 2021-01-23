import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = context.watch<Counter>();
    return Scaffold(
      body: Center(
        child: Text(
          '${counter.value}',
          style: TextStyle(fontSize: ScreenUtil().setSp(54.0)),
        ),
      ),
    );
  }
}
