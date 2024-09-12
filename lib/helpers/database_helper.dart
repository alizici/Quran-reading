import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
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

  Future<List<Map<String, dynamic>>> getAyetByPage(int pageNumber) async {
    final db = await database;
    return await db!.query(
      'Kuran',
      where: 'Sayfa = ?',
      whereArgs: [pageNumber],
    );
  }

  Future<int> getFirstPageOfSurah(int surahNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      'Kuran',
      where: 'Sure = ?',
      whereArgs: [surahNumber],
      orderBy: 'Sayfa ASC',
      limit: 1,
    );
    return result.isNotEmpty ? result.first['Sayfa'] : 1;
  }

  Future<List<Map<String, dynamic>>> getAyetAndMealBySurah(
      int surahNumber, String language) async {
    final db = await database;
    final ayetResults = await db!.query(
      'Kuran',
      columns: ['Ayet', 'textArapca', 'Sure', 'Id', 'Sayfa', 'Cuz'],
      where: 'Sure = ?',
      whereArgs: [surahNumber],
    );

    String mealTable = _getMealTable(language);

    List<Map<String, dynamic>> enrichedResults = [];
    for (var ayet in ayetResults) {
      var ayetMap = Map<String, dynamic>.from(ayet);
      int? ayetId = ayetMap['Id'];

      if (ayetId != null) {
        final List<Map<String, dynamic>> mealResults = await db.query(
          mealTable,
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayetId],
        );

        final List<Map<String, dynamic>> transcriptResults = await db.query(
          'transcript',
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayetId],
        );

        ayetMap['meal'] = mealResults.isNotEmpty
            ? (mealResults.first['text'] ?? "Meal metni boş")
            : "Meal bulunamadı";
        ayetMap['transcript'] = transcriptResults.isNotEmpty
            ? (transcriptResults.first['text'] ?? "Transcript metni boş")
            : "Transcript bulunamadı";
      } else {
        ayetMap['meal'] = "Meal ID'si bulunamadı";
        ayetMap['transcript'] = "Transcript ID'si bulunamadı";
      }

      enrichedResults.add(ayetMap);
    }

    return enrichedResults;
  }

  Future<List<Map<String, dynamic>>> searchByMeal(
      String searchText, String language) async {
    final db = await database;
    String mealTable = _getMealTable(language);

    final List<Map<String, dynamic>> mealResults = await db!.rawQuery('''
      SELECT k.*, m.text as meal, t.text as transcript
      FROM Kuran k
      JOIN $mealTable m ON k.Id = m.id
      LEFT JOIN transcript t ON k.Id = t.id
      WHERE m.text LIKE ?
    ''', ['%$searchText%']);

    return mealResults;
  }

  Future<List<Map<String, dynamic>>> searchByTranscript(
      String searchText) async {
    final db = await database;

    final List<Map<String, dynamic>> transcriptResults = await db!.rawQuery('''
      SELECT k.*, m.text as meal, t.text as transcript
      FROM Kuran k
      JOIN translation_tr m ON k.Id = m.id
      JOIN transcript t ON k.Id = t.id
      WHERE t.text LIKE ?
    ''', ['%$searchText%']);

    return transcriptResults;
  }

  Future<List<Map<String, dynamic>>> searchByArabicText(
      String searchText, String language) async {
    final db = await database;
    final ayetResults = await db!.query(
      'Kuran',
      columns: ['Ayet', 'textArapca', 'Sure', 'Id', 'Sayfa', 'Cuz'],
      where: 'textArapca LIKE ?',
      whereArgs: ['%$searchText%'],
    );

    String mealTable = _getMealTable(language);

    List<Map<String, dynamic>> enrichedResults = [];
    for (var ayet in ayetResults) {
      var ayetMap = Map<String, dynamic>.from(ayet);
      int? ayetId = ayetMap['Id'];

      if (ayetId != null) {
        final List<Map<String, dynamic>> mealResults = await db.query(
          mealTable,
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayetId],
        );

        final List<Map<String, dynamic>> transcriptResults = await db.query(
          'transcript',
          columns: ['text'],
          where: 'id = ?',
          whereArgs: [ayetId],
        );

        ayetMap['meal'] = mealResults.isNotEmpty
            ? (mealResults.first['text'] ?? "Meal metni boş")
            : "Meal bulunamadı";
        ayetMap['transcript'] = transcriptResults.isNotEmpty
            ? (transcriptResults.first['text'] ?? "Transcript metni boş")
            : "Transcript bulunamadı";
      } else {
        ayetMap['meal'] = "Meal ID'si bulunamadı";
        ayetMap['transcript'] = "Transcript ID'si bulunamadı";
      }

      enrichedResults.add(ayetMap);
    }

    return enrichedResults;
  }

  String _getMealTable(String language) {
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
