import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:heartrate_database_u_i/utils/time_helper.dart';

class PenyakitCard extends StatelessWidget {
  final String image;
  final String penyakit;
  final int record;
  final String updated;
  final void Function()? onTap;

  const PenyakitCard({
    super.key,
    required this.image,
    required this.penyakit,
    required this.record,
    required this.updated,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              child: CachedNetworkImage(
                imageUrl: dotenv.env['STORAGE_URL']! + image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 130,
                placeholder: (context, url) => const Center(
                  child:
                      CircularProgressIndicator(), // Placeholder saat gambar sedang dimuat
                ),
                errorWidget: (context, url, error) => const Icon(Icons
                    .error), // Menampilkan ikon error jika gagal memuat gambar
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    penyakit,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Menggunakan Wrap untuk memungkinkan teks membungkus jika overflow
                  Wrap(
                    spacing: 8, // Jarak antar elemen
                    runSpacing: 4, // Jarak antar baris
                    children: [
                      Text(
                        "$record Record",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "• Updated ${TimeHelper.formatTime(updated)}",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
