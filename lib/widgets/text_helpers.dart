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

String normalizeArabicText(String text) {
  final diacritics = RegExp(
      r'[\u064B-\u065F\u0617-\u061A\u06D6-\u06DC\u06DF-\u06E4\u06E7-\u06E8\u06EA-\u06ED]');
  return text
      .replaceAll(diacritics, '')
      .replaceAll("ي", "ی")
      .replaceAll("ك", "ک")
      .replaceAll("ه", "ة");
}