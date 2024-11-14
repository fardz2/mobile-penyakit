import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class PenyakitCard extends StatelessWidget {
  final String image;
  final String penyakit;
  final int record;
  final List<Map<String, dynamic>> listPenyakit;
  final String updated;
  final CrossAxisAlignment alignment; // Tambahkan parameter alignment

  const PenyakitCard({
    super.key,
    required this.image,
    required this.penyakit,
    required this.record,
    required this.updated,
    required this.alignment,
    required this.listPenyakit, // Required untuk alignment
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Jarakkan isi card dengan tombol
          crossAxisAlignment: alignment, // Gunakan parameter alignment
          children: [
            Column(
              crossAxisAlignment: alignment,
              children: [
                Text(
                  penyakit,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: alignment == CrossAxisAlignment.start
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Text(
                      "$record Record",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      " •  Updated $updated",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: alignment == CrossAxisAlignment.start
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  backgroundColor: customColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.DETAIL_PENYAKIT, arguments: {
                    "list_penyakit": listPenyakit,
                    "penyakit": penyakit,
                    "record": record,
                    "updated": updated
                  });
                },
                child: const Text(
                  "Read More",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
