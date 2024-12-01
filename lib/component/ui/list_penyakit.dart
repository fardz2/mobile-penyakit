import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class ListPenyakit extends StatelessWidget {
  final String name;
  final String jenis;
  final String tanggal;
  final String waktu;

  const ListPenyakit({
    super.key,
    required this.name,
    required this.jenis,
    required this.tanggal,
    required this.waktu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 20,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 70,
      width: double
          .infinity, // This makes the container take the full width of its parent
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the name with ellipsis in a fixed-width container
                    SizedBox(
                      width: 75, // Fixed width for name
                      child: Text(
                        name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight:
                              FontWeight.bold, // Optional: make name bold
                        ),
                        maxLines: 1, // Limit to 1 line
                      ),
                    ),
                    // Only show jenis if it's not empty in a fixed-width container
                    if (jenis.isNotEmpty)
                      SizedBox(
                        width: 100, // Fixed width for jenis
                        child: Text(
                          jenis,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1, // Limit to 1 line
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          // Only show tanggal and waktu if they are not empty
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (tanggal.isNotEmpty)
                SizedBox(
                  width: 80, // Fixed width for tanggal
                  child: Text(
                    tanggal,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1, // Limit to 1 line
                  ),
                ),
              if (waktu.isNotEmpty)
                SizedBox(
                  width: 65, // Fixed width for waktu
                  child: Text(
                    waktu,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1, // Limit to 1 line
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
