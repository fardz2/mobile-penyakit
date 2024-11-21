import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/ui/button_back.dart';

class DownloadHeaderWidget extends StatelessWidget {
  const DownloadHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ButtonBack(),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 30,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .transparent, // Mengatur latar belakang menjadi transparan
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(40, 40),
                  elevation: 0, // Menghilangkan elevation default
                ),
                child: SvgPicture.asset(
                  "assets/icons/svg/download.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                "assets/images/doctor_streamline.png",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
