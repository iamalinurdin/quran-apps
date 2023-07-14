import 'package:flutter/material.dart';
import 'package:quran_app/data/models/surah_model.dart';
import 'package:quran_app/ui/detail_page.dart';

class SurahItem extends StatelessWidget {
  final Surah surah;

  const SurahItem({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailPage.routeName, arguments: surah);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.bahasaName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    surah.translation,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${surah.verses} ayat, ${surah.location}'
                  )
                ],
              ),
              Text(
                surah.arabicName,
                style: const TextStyle(
                  fontSize: 24
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}