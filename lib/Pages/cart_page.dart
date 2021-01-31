import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List cartList = context.watch<CartProvider>().cartList;
            // print(context.watch<CartProvider>().totalCount);
            return Stack(
              children: [
                ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return CartItem(cartList[index]);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CaetBottom(),
                )
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    // print(1);
    await Provider.of<CartProvider>(context, listen: false).getCartInfo();
    return 'end';
  }
}
