import 'package:flutter/material.dart';

class VerseItem extends StatelessWidget {
  final Map<String, dynamic> verse;

  const VerseItem({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                verse['teksArab'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(verse['teksLatin']),
            const SizedBox(height: 8),
            Text(
              verse['teksIndonesia'],
              style: const TextStyle(
                fontSize: 16
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle), 
                  label: const Text('Putar Ayat')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}