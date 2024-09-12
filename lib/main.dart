import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stores/quran_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:async';
import 'quran_page_template.dart';
//import 'text_helpers.dart';

class AppColors {
  static const Color primaryColor = Colors.teal;
  static const Color accentColor = Colors.amber;
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Colors.black87;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuranStore>(create: (_) => QuranStore()),
      ],
      child: MaterialApp(
        home: const AnimatedHomeScreen(),
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          fontFamily: 'ArabicFont',
          textTheme: TextTheme(
            displayLarge: TextStyle(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(color: AppColors.textColor, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class AnimatedHomeScreen extends StatefulWidget {
  const AnimatedHomeScreen({super.key});

  @override
  _AnimatedHomeScreenState createState() => _AnimatedHomeScreenState();
}

class _AnimatedHomeScreenState extends State<AnimatedHomeScreen> {
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _startColorAnimation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() => _colorIndex = (_colorIndex + 1) % 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _colorIndex == 0
                ? [
                    AppColors.primaryColor.withOpacity(0.3),
                    AppColors.primaryColor.withOpacity(0.1),
                  ]
                : [
                    AppColors.primaryColor.withOpacity(0.5),
                    AppColors.primaryColor.withOpacity(0.3),
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildNavigationCard(
                  context,
                  'Sureler',
                  'assets/sure.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SurahPageViewScreen()),
                  ),
                ),
                const SizedBox(height: 16),
                buildNavigationCard(
                  context,
                  'Ayetler',
                  'assets/ayetmeal.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AyahScreen()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavigationCard(BuildContext context, String title,
      String assetPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedCard extends StatefulWidget {
  final String title;
  final String assetPath;

  const AnimatedCard({super.key, required this.title, required this.assetPath});

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  double _scale = 1.0;

  void _onPointerDown(PointerDownEvent event) => setState(() => _scale = 1.05);
  void _onPointerUp(PointerUpEvent event) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: 250,
          margin: const EdgeInsets.only(top: 40.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.assetPath), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Center(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    store.fetchAyetByPage(1);
    _pageController = PageController();
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
      store.fetchAyetByPage(pageNumber);
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
              onPageChanged: (index) => store.fetchAyetByPage(index + 1),
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
                  surahNames: store.surahInfo
                      .map((info) => info["name"] as String)
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AyahScreen extends StatefulWidget {
  const AyahScreen({Key? key}) : super(key: key);

  @override
  _AyahScreenState createState() => _AyahScreenState();
}

class _AyahScreenState extends State<AyahScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  double fontSize = 18.0;
  bool showTranscript = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = Provider.of<QuranStore>(context, listen: false);
      store.fetchAyetAndMealBySurah(store.currentSurah);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void toggleTranscript(bool value) {
    setState(() {
      showTranscript = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuranStore>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBarWithSearch(
          context, store, _searchController, _focusNode, this),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Observer(
                // Burayı Observer ile sarmalayalım
                builder: (_) => store.ayetList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: store.ayetList.length,
                        itemBuilder: (context, index) {
                          var ayet = store.ayetList[index];
                          String surahName = store.surahNames[ayet['Sure'] - 1];
                          int ayetNumber = ayet['Ayet'];
                          int pageNumber = ayet['Sayfa'];
                          int juzNumber = ayet['Cuz'];

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    ayet['textArapca'],
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'ArabicFont',
                                      fontSize: fontSize + 6,
                                      color: Colors.teal.shade900,
                                      height: 1.5,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    '($surahName, Ayet: $ayetNumber, Sayfa: $pageNumber, Cüz: $juzNumber)',
                                    style: TextStyle(
                                      fontSize: fontSize - 4,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  if (showTranscript) ...[
                                    Text(
                                      'Türkçe Okunuş:',
                                      style: TextStyle(
                                        fontSize: fontSize - 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal.shade700,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      ayet['transcript'],
                                      style: TextStyle(
                                        fontSize: fontSize,
                                        color: Colors.black54,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                  ],
                                  Text(
                                    'Meal:',
                                    style: TextStyle(
                                      fontSize: fontSize - 2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    ayet['meal'],
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            _buildFontSizeControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildFontSizeControls() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (fontSize > 12) fontSize -= 2;
              });
            },
          ),
          const Text('Font Boyutu', style: TextStyle(fontSize: 16)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                if (fontSize < 30) fontSize += 2;
              });
            },
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget buildAppBarWithSearch(
    BuildContext context,
    QuranStore store,
    TextEditingController searchController,
    FocusNode focusNode,
    _AyahScreenState state) {
  return AppBar(
    title: const Text('Ayetler'),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.teal.shade900),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      buildSearchButton(context, store, searchController, focusNode),
      buildLanguageButton(context, state, store),
      buildSurahSelectionButton(context, store, state),
    ],
  );
}

Widget buildSurahSelectionButton(
    BuildContext context, QuranStore store, _AyahScreenState state) {
  return IconButton(
    icon: Icon(Icons.list, color: Colors.teal.shade900),
    onPressed: () => showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: store.surahNames.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(store.surahNames[index]),
          onTap: () {
            store.fetchAyetAndMealBySurah(index + 1);
            //state.setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}

Widget buildSearchButton(BuildContext context, QuranStore store,
    TextEditingController searchController, FocusNode focusNode) {
  return IconButton(
    icon: Icon(Icons.search, color: Colors.teal.shade900),
    onPressed: () => showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchType = 'meal'; // Varsayılan arama türü
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Arama türü seç'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: searchType,
                    items: const [
                      DropdownMenuItem(
                          value: 'arabic', child: Text('Arapça Metin')),
                      DropdownMenuItem(value: 'meal', child: Text('Meal')),
                      DropdownMenuItem(
                          value: 'transcript', child: Text('Türkçe Okunuş')),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        searchType = newValue!;
                      });
                    },
                  ),
                  TextField(
                    controller: searchController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Aramak istediğiniz metni yazın',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Ara'),
                  onPressed: () {
                    if (searchController.text.isNotEmpty) {
                      switch (searchType) {
                        case 'arabic':
                          store
                              .searchByArabicText(searchController.text)
                              .then((_) {
                            Navigator.pop(context);
                          });
                          break;
                        case 'meal':
                          store.searchByMeal(searchController.text).then((_) {
                            Navigator.pop(context);
                          });
                          break;
                        case 'transcript':
                          store
                              .searchByTranscript(searchController.text)
                              .then((_) {
                            Navigator.pop(context);
                          });
                          break;
                      }
                    }
                  },
                ),
                TextButton(
                  child: const Text('İptal'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    ),
  );
}

Widget buildLanguageButton(
    BuildContext context, _AyahScreenState state, QuranStore store) {
  return IconButton(
    icon: Icon(Icons.language, color: Colors.teal.shade900),
    onPressed: () {
      showLanguageSelectionDialog(context, state, store);
    },
  );
}

void showLanguageSelectionDialog(
    BuildContext context, _AyahScreenState state, QuranStore store) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("Dil ve Görünüm Seçenekleri"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text("Türkçe"),
                  onTap: () {
                    store.changeLanguage("Türkçe");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text("İngilizce"),
                  onTap: () {
                    store.changeLanguage("İngilizce");
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text("Almanca"),
                  onTap: () {
                    store.changeLanguage("Almanca");
                    Navigator.pop(context);
                  },
                ),
                SwitchListTile(
                  title: const Text("Türkçe Okunuş"),
                  value: state.showTranscript,
                  onChanged: (bool value) {
                    setState(() {
                      state.toggleTranscript(value);
                    });
                  },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
