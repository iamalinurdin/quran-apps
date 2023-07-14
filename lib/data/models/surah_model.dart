class SurahResult {
  final String message;
  final List<Surah> results;

  SurahResult({required this.message, required this.results});

  factory SurahResult.fromJson(Map<String, dynamic> json) => SurahResult(
    message: json['message'], 
    results: List<Surah>.from(
      (json['data'] as List)
        .map(
          (item) => Surah.fromJson(item)
        )
      )
  );
}

class Surah {
  final int number;
  final String arabicName;
  final String bahasaName;
  final String location;
  final String description;
  final String translation;
  final int verses;
  final Map<String, dynamic> audioFull;
  final List? verse;

  Surah({
    required this.number,
    required this.arabicName,
    required this.bahasaName,
    required this.location,
    required this.description,
    required this.audioFull,
    required this.translation,
    required this.verses,
    required this.verse
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
    number: json['nomor'], 
    arabicName: json['nama'], 
    bahasaName: json['namaLatin'], 
    location: json['tempatTurun'], 
    description: json['deskripsi'], 
    audioFull: json['audioFull'],
    translation: json['arti'],
    verses: json['jumlahAyat'],
    verse: json['ayat']
  );
}