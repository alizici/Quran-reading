import 'package:flutter/material.dart';

String getArabicNumber(String text) {
  final arabicChars = ["٠", "١", "٢", "٣", "٤", "٥", "٦", "٧", "٨", "٩"];
  var result = String.fromCharCode(0xFD3F);
  for (var ch in text.split('')) {
    if (RegExp(r'^[0-9]$').hasMatch(ch)) {
      int index = int.parse(ch);
      result += arabicChars[index];
    } else {
      result += ch;
    }
  }
  result += String.fromCharCode(0xFD3E);
  return result;
}

String getArabicDigitsOnly(String number) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.split('').map((char) {
    return int.tryParse(char) != null ? arabicDigits[int.parse(char)] : char;
  }).join('');
}

TextSpan buildAyahNumber(String number, double fontSize) {
  return TextSpan(
    text: " \uFD3F$number\uFD3E ",
    style: TextStyle(
      color: const Color(0xFFDB0032),
      fontSize: fontSize,
    ),
  );
}

/*
Widget buildCombinedTextForSurah(
    BuildContext context, List<Map<String, dynamic>> ayetList) {
  String combinedText = ayetList.map((ayet) {
    String ayetNumarasiText = getArabicNumber(ayet['Ayet'].toString());
    return "${ayet['textArapca']} $ayetNumarasiText ";
  }).join();

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Text(
        combinedText,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'ArabicFont',
          fontSize: 24.0,
          color: Colors.teal.shade900,
          height: 1.5,
        ),
        textDirection: TextDirection.rtl,
        softWrap: true,
        overflow: TextOverflow.visible,
      ),
    ),
  );
}

Widget buildCombinedTextForAyah(
    BuildContext context, List<Map<String, dynamic>> ayetList) {
  return ListView.builder(
    itemCount: ayetList.length,
    itemBuilder: (context, index) {
      String ayetNumarasiText =
          getArabicNumber(ayetList[index]['Ayet'].toString());
      String ayetMetni = ayetList[index]['textArapca'];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          "$ayetMetni $ayetNumarasiText",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'ArabicFont',
            fontSize: 24.0,
            color: Colors.teal.shade900,
            height: 1.5,
          ),
          textDirection: TextDirection.rtl,
        ),
      );
    },
  );
}
*/
String normalizeArabicText(String text) {
  final diacritics = RegExp(
      r'[\u064B-\u065F\u0617-\u061A\u06D6-\u06DC\u06DF-\u06E4\u06E7-\u06E8\u06EA-\u06ED]');
  return text
      .replaceAll(diacritics, '')
      .replaceAll("ي", "ی")
      .replaceAll("ك", "ک")
      .replaceAll("ه", "ة");
}
