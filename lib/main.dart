import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart'; // Import the package for controlling orientation
import 'app/routes/app_pages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await FlutterDownloader.initialize(
      debug: true, ignoreSsl: true // Mengaktifkan debug log
      );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode (upward)
    DeviceOrientation.portraitDown, // Portrait mode (downward)
  ]);

  String initialRoute = await checkInitialRoute();

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      builder: FToastBuilder(),
      theme: ThemeData(
          fontFamily: GoogleFonts.onest().fontFamily,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    ),
  );
  FlutterNativeSplash.remove();
}

Future<String> checkInitialRoute() async {
  String? isFirstTime = GetStorage().read('isFirstTime');

  if (isFirstTime != null) {
    return Routes.LANDING;
  }
  return Routes.OPENING;
}
