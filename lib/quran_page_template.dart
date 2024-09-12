import 'package:flutter/material.dart';
import 'text_helpers.dart';
import 'package:provider/provider.dart';
import 'stores/quran_store.dart';

class QuranPageViewScreen extends StatefulWidget {
  final List<Map<String, dynamic>> allPagesData;
  final int initialPage;

  const QuranPageViewScreen({
    super.key,
    required this.allPagesData,
    required this.initialPage,
  });

  @override
  _QuranPageViewScreenState createState() => _QuranPageViewScreenState();
}

class _QuranPageViewScreenState extends State<QuranPageViewScreen> {
  late PageController _pageController;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.initialPage;
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuranStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Quran Pages - Page ${getArabicNumber((currentPageIndex + 1).toString())}'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => currentPageIndex = index),
        physics: const PageScrollPhysics(),
        itemCount: widget.allPagesData.length,
        itemBuilder: (context, index) => QuranPageTemplate(
          surahName: widget.allPagesData[index]['surahName'],
          surahNumber: widget.allPagesData[index]['surahNumber'],
          pageNumber: widget.allPagesData[index]['pageNumber'],
          juzNumber: widget.allPagesData[index]['juzNumber'],
          ayatList: widget.allPagesData[index]['ayatList'],
          surahNames: store.surahNames, // Buraya surahNames listesini ekledik
        ),
      ),
    );
  }
}

class QuranPageTemplate extends StatefulWidget {
  final String surahName;
  final int surahNumber;
  final int pageNumber;
  final int juzNumber;
  final List<Map<String, dynamic>> ayatList;
  final List<String> surahNames;

  const QuranPageTemplate({
    super.key,
    required this.surahName,
    required this.surahNumber,
    required this.pageNumber,
    required this.juzNumber,
    required this.ayatList,
    required this.surahNames,
  });

  @override
  _QuranPageTemplateState createState() => _QuranPageTemplateState();
}

class _QuranPageTemplateState extends State<QuranPageTemplate> {
  double fontSize = 20.0;
  double lineHeight = 1.85;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double baseFontSize = screenHeight * 0.024;

    String arabicPageNumber = getArabicDigitsOnly(widget.pageNumber.toString());

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        children: [
          _buildBackground(),
          _buildTopInfoBar(baseFontSize),
          _buildPageContent(),
          _buildBottomControls(baseFontSize, arabicPageNumber),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/shema.png'),
          fit: BoxFit.contain,
        ),
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildTopInfoBar(double baseFontSize) {
    Set<String> surahNames = <String>{};
    for (var ayet in widget.ayatList) {
      int surahNumber = ayet['Sure'] as int;
      surahNames
          .add(widget.surahNames[surahNumber - 1]); // Doğru sure adını alıyoruz
    }
    String surahText =
        surahNames.toList().join(" - "); // Sure adlarını birleştiriyoruz

    return Positioned(
      top: 5,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Cüz ${widget.juzNumber}",
            style: TextStyle(fontSize: baseFontSize * 0.8, color: Colors.brown),
          ),
          Expanded(
            child: Text(
              surahText,
              style: TextStyle(
                  fontSize: baseFontSize,
                  color: Colors.brown,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _buildHeaderWidget(int surahNumber) {
    final store = Provider.of<QuranStore>(context, listen: false);
    Map<String, dynamic> surahInfo = store.getSurahInfo(surahNumber);
    String arabicSurahName = surahInfo["arabicName"] as String;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/header.png'),
            fit: BoxFit.contain,
          ),
        ),
        height: 93,
        child: Center(
          child: Text(
            arabicSurahName,
            style: const TextStyle(fontSize: 24, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      bottom: 60,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _buildPageContentWidgets(),
        ),
      ),
    );
  }

  List<Widget> _buildPageContentWidgets() {
    List<Widget> pageContent = [];
    int? currentSurah;
    String currentAyahText = "";

    for (var ayet in widget.ayatList) {
      int ayetNumber = ayet['Ayet'] as int;
      int surahNumber = ayet['Sure'] as int;
      String ayetText = ayet['textArapca'] as String;

      if (currentSurah != surahNumber) {
        if (currentAyahText.isNotEmpty) {
          pageContent.add(_buildTextWidget(currentAyahText));
          currentAyahText = "";
        }

        if (ayetNumber == 1) {
          pageContent.add(_buildHeaderWidget(surahNumber));
        }
        currentSurah = surahNumber;
      }

      String ayetNumberText = getArabicNumber(ayetNumber.toString());
      currentAyahText += "$ayetText $ayetNumberText ";
    }

    if (currentAyahText.isNotEmpty) {
      pageContent.add(_buildTextWidget(currentAyahText));
    }

    return pageContent;
  }

  Widget _buildTextWidget(String text) {
    List<InlineSpan> textSpans = [];
    final ayetRegex = RegExp(r'(.*?)(\s*\uFD3F[\u0600-\u06FF]+\uFD3E\s*)');
    final matches = ayetRegex.allMatches(text);

    for (var match in matches) {
      if (match.group(1) != null) {
        textSpans.add(TextSpan(
          text: match.group(1),
          style: TextStyle(
            fontFamily: 'ArabicFont',
            fontSize: fontSize,
            height: lineHeight,
            color: Colors.black,
          ),
        ));
      }
      if (match.group(2) != null) {
        String numberStr =
            match.group(2)!.replaceAll(RegExp(r'[^\u0600-\u06FF]'), '');
        textSpans.add(buildAyahNumber(numberStr, fontSize));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        text: TextSpan(children: textSpans),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget _buildBottomControls(double baseFontSize, String arabicPageNumber) {
    return Positioned(
      bottom: 10,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => setState(
                () => fontSize = fontSize > 14 ? fontSize - 2 : fontSize),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                arabicPageNumber,
                style: TextStyle(
                    fontSize: baseFontSize * 1.2, color: Colors.brown),
              ),
              const SizedBox(width: 8),
              Text(
                "(${widget.pageNumber})",
                style: TextStyle(fontSize: baseFontSize, color: Colors.brown),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => setState(() => fontSize += 2),
          ),
        ],
      ),
    );
  }
}
