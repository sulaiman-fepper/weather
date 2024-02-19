import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:weather/utils/routes/routes.dart';
import 'package:weather/utils/routes/routes_name.dart';
import 'package:weather/view/location_selection_screen.dart';
import 'package:weather/view_model/weather_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        // ChangeNotifierProvider(create: (_) => CoursesViewModel()),
      ],
      child: ScreenUtilInit(
        child: GetMaterialApp(
          builder: EasyLoading.init(),
          initialRoute: RoutesName.login,
          getPages: Routes.list,
          theme: ThemeData(
            fontFamily: 'SFPRODISPLAY',
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0)),
            // bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent)
          ),
        ),
      )
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LocationDisplayScreen(),
    );
  }
}
