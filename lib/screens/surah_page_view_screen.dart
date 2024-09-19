import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/quran_store.dart';
import '../widgets/quran_page_template.dart';

class SurahPageViewScreen extends StatefulWidget {
  const SurahPageViewScreen({super.key});

  @override
  _SurahPageViewScreenState createState() => _SurahPageViewScreenState();
}

class _SurahPageViewScreenState extends State<SurahPageViewScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final store = Provider.of<QuranStore>(context, listen: false);
    store.fetchAyahByPage(1);
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToSurah(QuranStore store, int surahNumber) async {
    final int pageNumber = await store.getPageForSurah(surahNumber);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageNumber - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      store.fetchAyahByPage(pageNumber);
    }
  }

  PreferredSizeWidget buildSurahAppBar(BuildContext context, QuranStore store) {
    return AppBar(
      title: const Text('Sureler'),
      backgroundColor: Colors.teal.shade600,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.list, color: Colors.white),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => ListView.builder(
              itemCount: store.surahNames.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(store.surahNames[index]),
                onTap: () {
                  _goToSurah(store, index + 1);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuranStore>(context);

    return Scaffold(
      appBar: buildSurahAppBar(context, store),
      body: Observer(
        builder: (_) {
          if (store.pageContent.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) => store.fetchAyahByPage(index + 1),
              itemCount: store.totalPages,
              itemBuilder: (context, index) {
                final int surahNumber = store.pageContent.first['Sure'];
                final String surahName =
                    store.surahInfo[surahNumber - 1]["name"];

                return QuranPageTemplate(
                  surahName: surahName,
                  surahNumber: surahNumber,
                  pageNumber: index + 1,
                  juzNumber: store.juzNumber,
                  ayatList: store.pageContent,
                  surahNames: store.surahNames,
                );
              },
            );
          }
        },
      ),
    );
  }
}