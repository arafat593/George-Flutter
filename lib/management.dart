import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/data/theme.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/app_size.dart';

class Management extends StatelessWidget {
  const Management({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      theme: themeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        AppSize.size = MediaQuery.of(context).size;
        return child!;
      },
    );
  }
}
