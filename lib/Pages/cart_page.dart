import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../provider/counter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [Number(), MyButton()],
      )),
    );
  }
}

class Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = context.watch<Counter>();
    return Container(
      margin: EdgeInsets.only(top: 200),
      child: Text(
        '${counter.value}',
        style: TextStyle(fontSize: ScreenUtil().setSp(54.0)),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: Text('递增'),
      ),
    );
  }
}
