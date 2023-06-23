import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_app/data/models/surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/widgets/surah_item.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<SurahResult> surahList;

  Future<SurahResult> fetchSurah() async {
    final response = await http.get(Uri.parse('https://equran.id/api/v2/surat'));

    if (response.statusCode == 200) {
      return SurahResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('failed to fetch surah');
    }
  }

  @override
  void initState() {
    super.initState();
    surahList = fetchSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Assalamu\'alaikum'),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<SurahResult>(
                future: surahList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.results.length,
                        itemBuilder: (context, index) {
                          dynamic surah = snapshot.data?.results[index];
                          return SurahItem(surah: surah);
                        }
                      );
                    } else {
                      return Text('data');
                    }
                  }
                },
            
              ),
            )

          ],
        ),
      ),
    );
  }
}