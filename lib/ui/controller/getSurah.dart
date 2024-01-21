import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/surah.dart';

class GetSurah {
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    List<Surah> surahList = data.map((json) => Surah.fromJson(json)).toList();

    return surahList;
  }
}
