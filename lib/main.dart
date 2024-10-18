import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(
          fontFamily: GoogleFonts.onest().fontFamily,
          scaffoldBackgroundColor: Colors.white),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
