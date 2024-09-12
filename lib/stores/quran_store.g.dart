// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuranStore on QuranStoreBase, Store {
  late final _$ayetListAtom =
      Atom(name: 'QuranStoreBase.ayetList', context: context);

  @override
  List<Map<String, dynamic>> get ayetList {
    _$ayetListAtom.reportRead();
    return super.ayetList;
  }

  @override
  set ayetList(List<Map<String, dynamic>> value) {
    _$ayetListAtom.reportWrite(value, super.ayetList, () {
      super.ayetList = value;
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

  late final _$fetchAyetByPageAsyncAction =
      AsyncAction('QuranStoreBase.fetchAyetByPage', context: context);

  @override
  Future<void> fetchAyetByPage(int pageNumber) {
    return _$fetchAyetByPageAsyncAction
        .run(() => super.fetchAyetByPage(pageNumber));
  }

  late final _$fetchAyetAndMealBySurahAsyncAction =
      AsyncAction('QuranStoreBase.fetchAyetAndMealBySurah', context: context);

  @override
  Future<void> fetchAyetAndMealBySurah(int surahNumber) {
    return _$fetchAyetAndMealBySurahAsyncAction
        .run(() => super.fetchAyetAndMealBySurah(surahNumber));
  }

  late final _$searchByArabicTextAsyncAction =
      AsyncAction('QuranStoreBase.searchByArabicText', context: context);

  @override
  Future<void> searchByArabicText(String searchText) {
    return _$searchByArabicTextAsyncAction
        .run(() => super.searchByArabicText(searchText));
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
  String toString() {
    return '''
ayetList: ${ayetList},
selectedLanguage: ${selectedLanguage},
currentSurah: ${currentSurah},
currentAyah: ${currentAyah},
currentPage: ${currentPage},
juzNumber: ${juzNumber},
pageContent: ${pageContent},
totalPages: ${totalPages}
    ''';
  }
}
