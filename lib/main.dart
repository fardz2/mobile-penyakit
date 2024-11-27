import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/services.dart'; // Import the package for controlling orientation
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await FlutterDownloader.initialize(
      debug: true, ignoreSsl: true // Mengaktifkan debug log
      );
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
  String? isFirstTime = GetStorage().read('isFirstTime');

  if (isFirstTime != null) {
    return Routes.LANDING;
  }
  return Routes.OPENING;
}
