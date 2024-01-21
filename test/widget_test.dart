// import 'package:http/http.dart' as http;
// import 'package:quran/model/sub.dart';
// import 'dart:convert';

// import 'package:quran/model/surah.dart';

// void main() async {
//   Uri url = Uri.parse("https://api.quran.gading.dev/surah");
//   // Uri url = Uri.parse("https://api.quran.gading.dev/surah/1");

//   var res = await http.get(url);

//   List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
//   // print(data);
//   //model surah
//   Surah surahAlfatihah = Surah.fromJson(data[0]);
//   // print(surahAlfatihah.number);

//   Uri urlAlfatiha =
//       Uri.parse("https://api.quran.gading.dev/surah/${surahAlfatihah.number}");
//   var resAlfatiha = await http.get(urlAlfatiha);
//   Map<String, dynamic> dataAlfatiha =
//       (json.decode(resAlfatiha.body) as Map<String, dynamic>)["data"];

//   Sub alfatiha = Sub.fromJson(dataAlfatiha);

//   for (var verse in alfatiha.verses) {
//     print(verse.text.arab);
//   }
// }
