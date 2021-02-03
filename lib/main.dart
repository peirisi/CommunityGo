import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Pages/index_page.dart';
import 'package:provider/provider.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';
import './provider/details_info.dart';
import './provider/cart.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';
import './provider/CurentIndex.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChildCategory()),
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvider()),
        ChangeNotifierProvider(create: (_) => DetailsInfoProvide()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return ScreenUtilInit(
      designSize: Size(750, 1334),
      child: Container(
        child: MaterialApp(
          title: '社区购',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Color(0xFF7fca3e)),
          home: IndexPage(),
        ),
      ),
    );
  }
}
