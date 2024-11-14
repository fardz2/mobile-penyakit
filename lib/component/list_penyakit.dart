import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class ListPenyakit extends StatelessWidget {
  final String name;
  final String jenis;
  final String tanggal;
  final String waktu;
  const ListPenyakit(
      {super.key,
      required this.name,
      required this.jenis,
      required this.tanggal,
      required this.waktu});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white, // Tambahkan warna latar belakang untuk efek shadow
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 3), // Posisi bayangan
          ),
        ],
      ),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: customColor3,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SvgPicture.asset(
                  "assets/icons/svg/arrytmia.svg",
                  width: 5,
                  height: 5,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "Jenis penyakit • $jenis",
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tanggal,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                waktu,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
