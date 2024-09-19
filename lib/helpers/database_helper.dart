import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "kd.sqlite");

    if (!await File(path).exists()) {
      ByteData data = await rootBundle.load('assets/kd.sqlite');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path, readOnly: true);
  }

  Future<List<Map<String, dynamic>>> getAyahByPage(int pageNumber) async {
    final db = await database;
    return await db.query(
      'Kuran',
      where: 'Sayfa = ?',
      whereArgs: [pageNumber],
    );
  }

  Future<int> getFirstPageOfSurah(int surahNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'Kuran',
      where: 'Sure = ?',
      whereArgs: [surahNumber],
      orderBy: 'Sayfa ASC',
      limit: 1,
    );
    return result.isNotEmpty ? result.first['Sayfa'] : 1;
  }

  Future<List<Map<String, dynamic>>> getAyahAndTranslationBySurah(
      int surahNumber, String language) async {
    final db = await database;
    final ayahResults = await db.query(
      'Kuran',
      columns: ['Ayet', 'textArapca', 'Sure', 'Id', 'Sayfa', 'Cuz'],
      where: 'Sure = ?',
      whereArgs: [surahNumber],
    );

    String translationTable = _getTranslationTable(language);

    List<Map<String, dynamic>> enrichedResults = [];
    for (var ayah in ayahResults) {
      var ayahMap = Map<String, dynamic>.from(ayah);
      int? ayahId = ayahMap['Id'];

      if (ayahId != null) {
        final List<Map<String, dynamic>> translationResults = await db.query(
          translationTable,
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayahId],
        );

        final List<Map<String, dynamic>> transcriptResults = await db.query(
          'transcript',
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayahId],
        );

        ayahMap['translation'] = translationResults.isNotEmpty
            ? (translationResults.first['text'] ?? "Çeviri metni boş")
            : "Çeviri bulunamadı";
        ayahMap['transcript'] = transcriptResults.isNotEmpty
            ? (transcriptResults.first['text'] ?? "Transkript metni boş")
            : "Transkript bulunamadı";
      } else {
        ayahMap['translation'] = "Çeviri ID'si bulunamadı";
        ayahMap['transcript'] = "Transkript ID'si bulunamadı";
      }

      enrichedResults.add(ayahMap);
    }

    return enrichedResults;
  }

  Future<List<Map<String, dynamic>>> searchByTranslation(
      String searchText, String language) async {
    final db = await database;
    String translationTable = _getTranslationTable(language);

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT k.*, m.text as translation, t.text as transcript
      FROM Kuran k
      JOIN $translationTable m ON k.Id = m.id
      LEFT JOIN transcript t ON k.Id = t.id
      WHERE m.text LIKE ?
    ''', ['%$searchText%']);

    return results;
  }

  Future<List<Map<String, dynamic>>> searchByTranscript(String searchText) async {
    final db = await database;

    final List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT k.*, m.text as translation, t.text as transcript
      FROM Kuran k
      JOIN translation_tr m ON k.Id = m.id
      JOIN transcript t ON k.Id = t.id
      WHERE t.text LIKE ?
    ''', ['%$searchText%']);

    return results;
  }

  Future<List<Map<String, dynamic>>> searchByArabicText(
      String searchText, String language) async {
    final db = await database;
    final ayahResults = await db.query(
      'Kuran',
      columns: ['Ayet', 'textArapca', 'Sure', 'Id', 'Sayfa', 'Cuz'],
      where: 'textArapca LIKE ?',
      whereArgs: ['%$searchText%'],
    );

    String translationTable = _getTranslationTable(language);

    List<Map<String, dynamic>> enrichedResults = [];
    for (var ayah in ayahResults) {
      var ayahMap = Map<String, dynamic>.from(ayah);
      int? ayahId = ayahMap['Id'];

      if (ayahId != null) {
        final List<Map<String, dynamic>> translationResults = await db.query(
          translationTable,
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayahId],
        );

        final List<Map<String, dynamic>> transcriptResults = await db.query(
          'transcript',
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayahId],
        );

        ayahMap['translation'] = translationResults.isNotEmpty
            ? (translationResults.first['text'] ?? "Çeviri metni boş")
            : "Çeviri bulunamadı";
        ayahMap['transcript'] = transcriptResults.isNotEmpty
            ? (transcriptResults.first['text'] ?? "Transkript metni boş")
            : "Transkript bulunamadı";
      } else {
        ayahMap['translation'] = "Çeviri ID'si bulunamadı";
        ayahMap['transcript'] = "Transkript ID'si bulunamadı";
      }

      enrichedResults.add(ayahMap);
    }

    return enrichedResults;
  }

  String _getTranslationTable(String language) {
    switch (language) {
      case "Türkçe":
        return 'translation_tr';
      case "İngilizce":
        return 'translation_en';
      case "Almanca":
        return 'translation_de';
      default:
        return 'translation_tr';
    }
  }
}