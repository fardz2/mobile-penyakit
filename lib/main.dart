import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart'; // Import the package for controlling orientation
import 'package:heartrate_database_u_i/app/modules/profile/controllers/profile_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode (upward)
    DeviceOrientation.portraitDown, // Portrait mode (downward)
  ]);

  String initialRoute = await checkInitialRoute();

  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
          fontFamily: GoogleFonts.onest().fontFamily,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    ),
  );
}

Future<String> checkInitialRoute() async {
  String? authToken = GetStorage().read('auth_token');
  String? isFirstTime = GetStorage().read('isFirstTime');

  if (authToken != null) {
    return Routes.LANDING;
  } else if (isFirstTime != null) {
    return Routes.LOGIN;
  }
  return Routes.OPENING;
}
