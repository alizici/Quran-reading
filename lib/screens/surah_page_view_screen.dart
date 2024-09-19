import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/quran_store.dart';
import '../widgets/quran_page_template.dart';
import '../theme.dart';

class SurahPageViewScreen extends StatefulWidget {
  const SurahPageViewScreen({super.key});

  @override
  _SurahPageViewScreenState createState() => _SurahPageViewScreenState();
}

class _SurahPageViewScreenState extends State<SurahPageViewScreen> {
  late PageController _pageController;
  late QuranStore _store;
  final Map<int, Future<List<Map<String, dynamic>>>> _pageCache = {};

  @override
  void initState() {
    super.initState();
    _store = Provider.of<QuranStore>(context, listen: false);
    _pageController = PageController(initialPage: 0);
    _preloadPages(1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _preloadPages(int currentPage) {
    for (int i = currentPage;
        i < currentPage + 3 && i <= _store.totalPages;
        i++) {
      if (!_pageCache.containsKey(i)) {
        _pageCache[i] = _store.fetchAyahByPage(i);
      }
    }
  }

  void _goToSurah(int surahNumber) async {
    final int pageNumber = await _store.getPageForSurah(surahNumber);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        pageNumber - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  PreferredSizeWidget buildSurahAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Sureler'),
      backgroundColor: AppColors.appBarColor,
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
              itemCount: _store.surahNames.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_store.surahNames[index]),
                onTap: () {
                  _goToSurah(index + 1);
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
    return Scaffold(
      appBar: buildSurahAppBar(context),
      body: PageView.builder(
        reverse: true,
        controller: _pageController,
        itemCount: _store.totalPages,
        onPageChanged: (index) {
          _preloadPages(index + 1);
        },
        itemBuilder: (context, index) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _pageCache[index + 1] ?? _store.fetchAyahByPage(index + 1),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              }

              final pageContent = snapshot.data!;
              final int surahNumber = pageContent.first['Sure'];
              final String surahName =
                  _store.surahInfo[surahNumber - 1]["name"];

              return QuranPageTemplate(
                surahName: surahName,
                surahNumber: surahNumber,
                pageNumber: index + 1,
                juzNumber: pageContent.first['Cuz'],
                ayatList: pageContent,
                surahNames: _store.surahNames,
              );
            },
          );
        },
      ),
    );
  }
}
