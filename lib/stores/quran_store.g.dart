// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuranStore on QuranStoreBase, Store {
  late final _$ayahListAtom =
      Atom(name: 'QuranStoreBase.ayahList', context: context);

  @override
  List<Map<String, dynamic>> get ayahList {
    _$ayahListAtom.reportRead();
    return super.ayahList;
  }

  @override
  set ayahList(List<Map<String, dynamic>> value) {
    _$ayahListAtom.reportWrite(value, super.ayahList, () {
      super.ayahList = value;
    });
  }

  late final _$selectedLanguageAtom =
      Atom(name: 'QuranStoreBase.selectedLanguage', context: context);

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$currentSurahAtom =
      Atom(name: 'QuranStoreBase.currentSurah', context: context);

  @override
  int get currentSurah {
    _$currentSurahAtom.reportRead();
    return super.currentSurah;
  }

  @override
  set currentSurah(int value) {
    _$currentSurahAtom.reportWrite(value, super.currentSurah, () {
      super.currentSurah = value;
    });
  }

  late final _$currentAyahAtom =
      Atom(name: 'QuranStoreBase.currentAyah', context: context);

  @override
  int get currentAyah {
    _$currentAyahAtom.reportRead();
    return super.currentAyah;
  }

  @override
  set currentAyah(int value) {
    _$currentAyahAtom.reportWrite(value, super.currentAyah, () {
      super.currentAyah = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: 'QuranStoreBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$juzNumberAtom =
      Atom(name: 'QuranStoreBase.juzNumber', context: context);

  @override
  int get juzNumber {
    _$juzNumberAtom.reportRead();
    return super.juzNumber;
  }

  @override
  set juzNumber(int value) {
    _$juzNumberAtom.reportWrite(value, super.juzNumber, () {
      super.juzNumber = value;
    });
  }

  late final _$pageContentAtom =
      Atom(name: 'QuranStoreBase.pageContent', context: context);

  @override
  List<Map<String, dynamic>> get pageContent {
    _$pageContentAtom.reportRead();
    return super.pageContent;
  }

  @override
  set pageContent(List<Map<String, dynamic>> value) {
    _$pageContentAtom.reportWrite(value, super.pageContent, () {
      super.pageContent = value;
    });
  }

  late final _$totalPagesAtom =
      Atom(name: 'QuranStoreBase.totalPages', context: context);

  @override
  int get totalPages {
    _$totalPagesAtom.reportRead();
    return super.totalPages;
  }

  @override
  set totalPages(int value) {
    _$totalPagesAtom.reportWrite(value, super.totalPages, () {
      super.totalPages = value;
    });
  }

  late final _$showTranscriptAtom =
      Atom(name: 'QuranStoreBase.showTranscript', context: context);

  @override
  bool get showTranscript {
    _$showTranscriptAtom.reportRead();
    return super.showTranscript;
  }

  @override
  set showTranscript(bool value) {
    _$showTranscriptAtom.reportWrite(value, super.showTranscript, () {
      super.showTranscript = value;
    });
  }

  late final _$fetchAyahByPageAsyncAction =
      AsyncAction('QuranStoreBase.fetchAyahByPage', context: context);

  @override
  Future<List<Map<String, dynamic>>> fetchAyahByPage(int pageNumber) {
    return _$fetchAyahByPageAsyncAction
        .run(() => super.fetchAyahByPage(pageNumber));
  }

  late final _$fetchAyahAndTranslationBySurahAsyncAction = AsyncAction(
      'QuranStoreBase.fetchAyahAndTranslationBySurah',
      context: context);

  @override
  Future<void> fetchAyahAndTranslationBySurah(int surahNumber) {
    return _$fetchAyahAndTranslationBySurahAsyncAction
        .run(() => super.fetchAyahAndTranslationBySurah(surahNumber));
  }

  late final _$searchByArabicTextAsyncAction =
      AsyncAction('QuranStoreBase.searchByArabicText', context: context);

  @override
  Future<void> searchByArabicText(String searchText) {
    return _$searchByArabicTextAsyncAction
        .run(() => super.searchByArabicText(searchText));
  }

  late final _$searchByTranslationAsyncAction =
      AsyncAction('QuranStoreBase.searchByTranslation', context: context);

  @override
  Future<void> searchByTranslation(String searchText) {
    return _$searchByTranslationAsyncAction
        .run(() => super.searchByTranslation(searchText));
  }

  late final _$searchByTranscriptAsyncAction =
      AsyncAction('QuranStoreBase.searchByTranscript', context: context);

  @override
  Future<void> searchByTranscript(String searchText) {
    return _$searchByTranscriptAsyncAction
        .run(() => super.searchByTranscript(searchText));
  }

  late final _$getPageForSurahAsyncAction =
      AsyncAction('QuranStoreBase.getPageForSurah', context: context);

  @override
  Future<int> getPageForSurah(int surahNumber) {
    return _$getPageForSurahAsyncAction
        .run(() => super.getPageForSurah(surahNumber));
  }

  late final _$QuranStoreBaseActionController =
      ActionController(name: 'QuranStoreBase', context: context);

  @override
  void changeLanguage(String language) {
    final _$actionInfo = _$QuranStoreBaseActionController.startAction(
        name: 'QuranStoreBase.changeLanguage');
    try {
      return super.changeLanguage(language);
    } finally {
      _$QuranStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleTranscript() {
    final _$actionInfo = _$QuranStoreBaseActionController.startAction(
        name: 'QuranStoreBase.toggleTranscript');
    try {
      return super.toggleTranscript();
    } finally {
      _$QuranStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ayahList: ${ayahList},
selectedLanguage: ${selectedLanguage},
currentSurah: ${currentSurah},
currentAyah: ${currentAyah},
currentPage: ${currentPage},
juzNumber: ${juzNumber},
pageContent: ${pageContent},
totalPages: ${totalPages},
showTranscript: ${showTranscript}
    ''';
  }
}
