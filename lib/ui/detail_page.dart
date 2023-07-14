import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quran_app/data/models/surah_model.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/widgets/verse_item.dart';

class DetailPage extends StatefulWidget {
  static String routeName = '/detail_page';
  final Surah surah;

  const DetailPage({super.key, required this.surah});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Surah> selectedSurah;

  Future<Surah> fetchSurah() async {
    final response = await http.get(Uri.parse('https://equran.id/api/v2/surat/${widget.surah.number}'));

    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data'];

      return Surah.fromJson(body);
    } else {
      throw Exception('failed to fetch surah');
    }
  }

  @override
  void initState() {
    super.initState();
    selectedSurah = fetchSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surah.bahasaName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.bookmark_outline)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: selectedSurah,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                // print('res: ${snapshot.data?.verse}');
                // return const Text('ok');
      
                return ListView.builder(
                  itemCount: snapshot.data?.verse!.length,
                  itemBuilder: (context, index) {
                    return VerseItem(verse: snapshot.data?.verse![index]);
                  },
                );
      
              } else {
                return const Text('ok');
              }
            }
          },
        ),
      ),
    );
  }
}