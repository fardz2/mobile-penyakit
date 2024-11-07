import 'package:flutter/material.dart';

class PenyakitCard extends StatelessWidget {
  final String image;
  final String penyakit;
  final int record;
  final String updated;

  const PenyakitCard({
    super.key,
    required this.image,
    required this.penyakit,
    required this.record,
    required this.updated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 130,
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
                Row(
                  children: [
                    Text(
                      "$record Record",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      " •  Updated $updated",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
