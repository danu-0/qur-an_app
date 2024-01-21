import 'package:flutter/material.dart';
import 'package:quran/ui/Detail.dart';
import 'package:quran/ui/controller/getSurah.dart';
import '../../model/surah.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Surah>> surahList;

  @override
  void initState() {
    super.initState();
    surahList = GetSurah().getAllSurah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Al Qur'an List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: surahList,
        builder: (context, AsyncSnapshot<List<Surah>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No data available"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Surah surah = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailSurahPage(surah: surah)));
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "${surah.number}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(
                  surah.name.transliteration.id,
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  'Ayat: ${surah.numberOfVerses} | ${surah.revelation.id}',
                ),
                trailing: Text(
                  surah.name.short,
                  style: TextStyle(fontSize: 20),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
