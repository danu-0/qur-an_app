import 'dart:convert';
import '../../model/sub.dart';
import 'package:http/http.dart' as http;

class GetDetailSurah {
  Future<Sub> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data = json.decode(res.body) as Map<String, dynamic>;
    Sub detailSurah = Sub.fromJson(data["data"]);

    print(data);

    return detailSurah;
  }
}
