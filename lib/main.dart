import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'Pages/index_page.dart';
import 'package:provider/provider.dart';
import './provider/counter.dart';
import './provider/child_category.dart';
import './provider/category_goods_list.dart';
import './provider/details_info.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './routers/application.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ChildCategory()),
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvider()),
        ChangeNotifierProvider(create: (_) => DetailsInfoProvide()),
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
          title: 'XXXX',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    );
  }
}
