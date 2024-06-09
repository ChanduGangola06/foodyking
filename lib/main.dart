import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodyking/app/app_bindings.dart';
import 'package:foodyking/app/modules/splash/splash_view.dart';
import 'package:foodyking/translation/language.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();
dynamic langValue = const Locale('en', null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FoodyKing',
          translations: Languages(),
          theme: ThemeData(useMaterial3: false),
          locale: langValue,
          initialBinding: AppBindings(context: context),
          home: const SplashView(),
        );
      },
    );
  }
}
