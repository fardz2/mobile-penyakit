// bullet_list_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BulletListCard extends StatelessWidget {
  final String title;
  final String icon;
  final List<String> items;

  const BulletListCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SvgPicture.asset(
                    width: 10,
                    height: 10,
                    icon,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('•'), // Simbol bullet
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(items[index]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
