import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/quran_store.dart';
import '../theme.dart';

class AyahScreen extends StatefulWidget {
  const AyahScreen({super.key});

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
      store.fetchAyahAndTranslationBySurah(store.currentSurah);
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
                builder: (_) => store.ayahList.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: store.ayahList.length,
                        itemBuilder: (context, index) {
                          var ayah = store.ayahList[index];
                          return _buildAyahCard(context, ayah, store);
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

  Widget _buildAyahCard(
      BuildContext context, Map<String, dynamic> ayah, QuranStore store) {
    String surahName = store.surahNames[ayah['Sure'] - 1];
    int ayahNumber = ayah['Ayet'];
    int pageNumber = ayah['Sayfa'];
    int juzNumber = ayah['Cuz'];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ayah['textArapca'],
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'ArabicFont',
                fontSize: fontSize + 6,
                color: AppColors.textColor,
                height: 1.5,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 8.0),
            Text(
              '($surahName, Ayet: $ayahNumber, Sayfa: $pageNumber, Cüz: $juzNumber)',
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
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                ayah['transcript'],
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
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              ayah['translation'],
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.black87,
              ),
            ),
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
    backgroundColor: AppColors.appBarColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
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
    icon: Icon(Icons.list, color: const Color.fromARGB(255, 255, 255, 255)),
    onPressed: () => showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: store.surahNames.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(store.surahNames[index]),
          onTap: () {
            store.fetchAyahAndTranslationBySurah(index + 1);
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
    icon: Icon(Icons.search, color: const Color.fromARGB(255, 255, 255, 255)),
    onPressed: () => showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchType = 'translation';
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
                      DropdownMenuItem(
                          value: 'translation', child: Text('Meal')),
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
                        case 'translation':
                          store
                              .searchByTranslation(searchController.text)
                              .then((_) {
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
    icon: Icon(Icons.language, color: Color.fromARGB(255, 255, 255, 255)),
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
                  activeColor: AppColors.primaryColor,
                  activeTrackColor: AppColors.primaryColor.withOpacity(0.5),
                  inactiveThumbColor: AppColors.appBarColor,
                  inactiveTrackColor: AppColors.appBarColor.withOpacity(0.5),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
