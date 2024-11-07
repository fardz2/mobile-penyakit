import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class ProfileButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Color shadowColor;

  const ProfileButton({
    super.key,
    required this.iconPath,
    required this.label,
    this.backgroundColor = customColor3,
    this.iconBackgroundColor = const Color(0xff554F9B),
    this.shadowColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final widthFull = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      width: widthFull,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 40,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 10,
                  height: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  _limitWords(label, 3), // Batasi menjadi 3 kata
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1, // Membatasi hanya satu baris teks
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SvgPicture.asset(
              "assets/icons/svg/chevron-double-right.svg",
              width: 10,
              height: 10,
              colorFilter: ColorFilter.mode(
                  iconBackgroundColor as Color, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membatasi jumlah kata
  String _limitWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    if (words.length > maxWords) {
      return '${words.sublist(0, maxWords).join(' ')}...';
    }
    return text;
  }
}
