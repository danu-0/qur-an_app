// DetailSurahPage.dart
import 'package:flutter/material.dart';
import 'package:quran/ui/controller/getDetailSurah.dart';
import '../../model/surah.dart';
import '../../model/sub.dart' as sub;

class DetailSurahPage extends StatelessWidget {
  final Surah surah; // Sesuaikan dengan nama model yang Anda gunakan

  const DetailSurahPage({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Surah ${surah.name.transliteration.id}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${surah.name.transliteration.id.toUpperCase()}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "(${surah.name.translation.id.toUpperCase()})",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${surah.numberOfVerses} Ayat | ${surah.revelation.id}",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder(
                  future:
                      GetDetailSurah().getDetailSurah(surah.number.toString()),
                  builder: (context, AsyncSnapshot<sub.Sub> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData || snapshot.data! == null) {
                      return Center(
                        child: Text("Data null"),
                      );
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: surah.numberOfVerses ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      snapshot.data!.verses[index].text.arab,
                                      style: TextStyle(fontSize: 25),
                                      textAlign: TextAlign.end,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot
                                          .data!.verses[index].translation.id,
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Ayat: ${index + 1}"),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.play_arrow)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.bookmark_add_outlined)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  }),
            )
          ],
        ));
  }
}
