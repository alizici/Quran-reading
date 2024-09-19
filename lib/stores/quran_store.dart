import 'package:mobx/mobx.dart';
import '../helpers/database_helper.dart';

part 'quran_store.g.dart';

class QuranStore = QuranStoreBase with _$QuranStore;

abstract class QuranStoreBase with Store {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @observable
  List<Map<String, dynamic>> ayahList = [];

  @observable
  String selectedLanguage = "Türkçe";

  @observable
  int currentSurah = 1;

  @observable
  int currentAyah = 1;

  @observable
  int currentPage = 1;

  @observable
  int juzNumber = 1;

  @observable
  List<Map<String, dynamic>> pageContent = [];

  @observable
  int totalPages = 604;

  @observable
  bool showTranscript = true;

  final List<Map<String, dynamic>> surahInfo = [
    {
      "number": 1,
      "name": "Fatiha",
      "arabicName": "سُورَةُ الفَاتِحَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سَبْعُ آيَاتٍ"
    },
    {
      "number": 2,
      "name": "Bakara",
      "arabicName": "سُورَةُ البَقَرَة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ مِئَتَانِ وَسِتَّةٌ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 3,
      "name": "Âl-i İmrân",
      "arabicName": "سُورَةُ آل عِمرَان",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ مِئَتَانِ آيَةً"
    },
    {
      "number": 4,
      "name": "Nisâ",
      "arabicName": "سُورَةُ النِّسَاء",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَسِتَّةٌ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 5,
      "name": "Mâide",
      "arabicName": "سُورَةُ المَائدة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 6,
      "name": "En‘âm",
      "arabicName": "سُورَةُ الأنعَام",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَخَمْسَةٌ وَسِتُّونَ آيَةً"
    },
    {
      "number": 7,
      "name": "A‘râf",
      "arabicName": "سُورَةُ الأعرَاف",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَتَانِ وَسِتُّ آيَاتٍ"
    },
    {
      "number": 8,
      "name": "Enfâl",
      "arabicName": "سُورَةُ الأنفَال",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 9,
      "name": "Tevbe",
      "arabicName": "سُورَةُ التوبَة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَتِسْعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 10,
      "name": "Yûnus",
      "arabicName": "سُورَةُ يُونس",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَتِسْعُ آيَاتٍ"
    },
    {
      "number": 11,
      "name": "Hûd",
      "arabicName": "سُورَةُ هُود",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَثَلَاثٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 12,
      "name": "Yûsuf",
      "arabicName": "سُورَةُ يُوسُف",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَإِحْدَى عَشْرَةَ آيَةً"
    },
    {
      "number": 13,
      "name": "Ra'd",
      "arabicName": "سُورَةُ الرَّعْد",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَلَاثٌ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 14,
      "name": "İbrâhîm",
      "arabicName": "سُورَةُ إبراهِيم",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ إِثْنَتَانِ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 15,
      "name": "Hicr",
      "arabicName": "سُورَةُ الحِجْر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَتِسْعُونَ آيَةً"
    },
    {
      "number": 16,
      "name": "Nahl",
      "arabicName": "سُورَةُ النَّحْل",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَثَمَانِيَةٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 17,
      "name": "İsra",
      "arabicName": "سُورَةُ الإسْرَاء",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَإِحْدَى عَشْرَةَ آيَةً"
    },
    {
      "number": 18,
      "name": "Kehf",
      "arabicName": "سُورَةُ الكهْف",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَعَشْرُ آيَاتٍ"
    },
    {
      "number": 19,
      "name": "Meryem",
      "arabicName": "سُورَةُ مَريَم",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانِيَةٌ وَتِسْعُونَ آيَةً"
    },
    {
      "number": 20,
      "name": "Tâ-hâ",
      "arabicName": "سُورَةُ طه",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَخَمْسٌ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 21,
      "name": "Enbiyâ",
      "arabicName": "سُورَةُ الأنبيَاء",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَاثْنَتَانِ عَشْرَةَ آيَةً"
    },
    {
      "number": 22,
      "name": "Hac",
      "arabicName": "سُورَةُ الحَج",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 23,
      "name": "Mü'minûn",
      "arabicName": "سُورَةُ المُؤمنون",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَثَمَانِيَةَ عَشَرَ آيَةً"
    },
    {
      "number": 24,
      "name": "Nûr",
      "arabicName": "سُورَةُ النُّور",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَسِتُّونَ آيَةً"
    },
    {
      "number": 25,
      "name": "Furkân",
      "arabicName": "سُورَةُ الفُرْقان",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سَبْعٌ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 26,
      "name": "Şu'arâ",
      "arabicName": "سُورَةُ الشُّعَرَاء",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَتَانِ وَسَبْعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 27,
      "name": "Neml",
      "arabicName": "سُورَةُ النَّمْل",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثٌ وَتِسْعُونَ آيَةً"
    },
    {
      "number": 28,
      "name": "Kasas",
      "arabicName": "سُورَةُ القَصَص",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 29,
      "name": "Ankebût",
      "arabicName": "سُورَةُ العَنكبوت",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَسِتُّونَ آيَةً"
    },
    {
      "number": 30,
      "name": "Rûm",
      "arabicName": "سُورَةُ الرُّوم",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتُّونَ آيَةً"
    },
    {
      "number": 31,
      "name": "Lokmân",
      "arabicName": "سُورَةُ لقمَان",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 32,
      "name": "Secde",
      "arabicName": "سُورَةُ السَّجدَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثُونَ آيَةً"
    },
    {
      "number": 33,
      "name": "Ahzâb",
      "arabicName": "سُورَةُ الأحزَاب",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَلَاثٌ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 34,
      "name": "Sebe'",
      "arabicName": "سُورَةُ سَبَأ",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 35,
      "name": "Fâtır",
      "arabicName": "سُورَةُ فَاطِر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 36,
      "name": "Yâsîn",
      "arabicName": "سُورَةُ يس",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانِيَةٌ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 37,
      "name": "Sâffât",
      "arabicName": "سُورَةُ الصَّافات",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ مِئَةٌ وَاثْنَتَانِ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 38,
      "name": "Sâd",
      "arabicName": "سُورَةُ ص",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 39,
      "name": "Zümer",
      "arabicName": "سُورَةُ الزُّمَر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 40,
      "name": "Gâfir",
      "arabicName": "سُورَةُ غَافِر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 41,
      "name": "Fussilet",
      "arabicName": "سُورَةُ فُصِّلَتْ",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 42,
      "name": "Şûrâ",
      "arabicName": "سُورَةُ الشُّورَى",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثٌ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 43,
      "name": "Zuhruf",
      "arabicName": "سُورَةُ الزُّخْرُف",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَثَمَانُونَ آيَةً"
    },
    {
      "number": 44,
      "name": "Duhân",
      "arabicName": "سُورَةُ الدُّخان",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 45,
      "name": "Câsiye",
      "arabicName": "سُورَةُ الجاثِية",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سَبْعٌ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 46,
      "name": "Ahkâf",
      "arabicName": "سُورَةُ الأحقاف",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 47,
      "name": "Muhammed",
      "arabicName": "سُورَةُ مُحَمّد",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 48,
      "name": "Feth",
      "arabicName": "سُورَةُ الفَتْح",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 49,
      "name": "Hucurât",
      "arabicName": "سُورَةُ الحُجُرات",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانِيَةَ عَشَرَ آيَةً"
    },
    {
      "number": 50,
      "name": "Kâf",
      "arabicName": "سُورَةُ ق",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 51,
      "name": "Zâriyat",
      "arabicName": "سُورَةُ الذَّاريَات",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتُّونَ آيَةً"
    },
    {
      "number": 52,
      "name": "Tûr",
      "arabicName": "سُورَةُ الطُّور",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 53,
      "name": "Necm",
      "arabicName": "سُورَةُ النَّجْم",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَسِتُّونَ آيَةً"
    },
    {
      "number": 54,
      "name": "Kamer",
      "arabicName": "سُورَةُ القَمَر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 55,
      "name": "Rahmân",
      "arabicName": "سُورَةُ الرَّحمن",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَسَبْعُونَ آيَةً"
    },
    {
      "number": 56,
      "name": "Vâkıa",
      "arabicName": "سُورَةُ الواقِعَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتٌّ وَتِسْعُونَ آيَةً"
    },
    {
      "number": 57,
      "name": "Hadîd",
      "arabicName": "سُورَةُ الحَديد",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 58,
      "name": "Mücâdele",
      "arabicName": "سُورَةُ المُجادَلة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 59,
      "name": "Haşr",
      "arabicName": "سُورَةُ الحَشْر",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 60,
      "name": "Mümtehıne",
      "arabicName": "سُورَةُ المُمتَحَنة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَلَاثَةَ عَشَرَ آيَةً"
    },
    {
      "number": 61,
      "name": "Saff",
      "arabicName": "سُورَةُ الصَّف",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ أَرْبَعَةَ عَشَرَ آيَةً"
    },
    {
      "number": 62,
      "name": "Cum'a",
      "arabicName": "سُورَةُ الجُّمُعة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ إِحْدَى عَشَرَ آيَةً"
    },
    {
      "number": 63,
      "name": "Münâfikûn",
      "arabicName": "سُورَةُ المُنافِقُون",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ إِحْدَى عَشَرَ آيَةً"
    },
    {
      "number": 64,
      "name": "Teğâbun",
      "arabicName": "سُورَةُ التَّغابُن",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانِيَةَ عَشَرَ آيَةً"
    },
    {
      "number": 65,
      "name": "Talâk",
      "arabicName": "سُورَةُ الطَّلاق",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ اثْنَتَا عَشَرَةَ آيَةً"
    },
    {
      "number": 66,
      "name": "Tahrîm",
      "arabicName": "سُورَةُ التَّحْريم",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ اثْنَتَا عَشَرَةَ آيَةً"
    },
    {
      "number": 67,
      "name": "Mülk",
      "arabicName": "سُورَةُ المُلْك",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثُونَ آيَةً"
    },
    {
      "number": 68,
      "name": "Kalem",
      "arabicName": "سُورَةُ القَلـََم",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 69,
      "name": "Hâkka",
      "arabicName": "سُورَةُ الحَاقّـَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 70,
      "name": "Me'âric",
      "arabicName": "سُورَةُ المَعارِج",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعٌ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 71,
      "name": "Nûh",
      "arabicName": "سُورَةُ نُوح",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 72,
      "name": "Cin",
      "arabicName": "سُورَةُ الجِنّ",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانٍ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 73,
      "name": "Müzzemmil",
      "arabicName": "سُورَةُ المُزَّمّـِل",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ عِشْرُونَ آيَةً"
    },
    {
      "number": 74,
      "name": "Müddessir",
      "arabicName": "سُورَةُ المُدَّثــِّر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتٌّ وَخَمْسُونَ آيَةً"
    },
    {
      "number": 75,
      "name": "Kıyâme",
      "arabicName": "سُورَةُ القِيامَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعُونَ آيَةً"
    },
    {
      "number": 76,
      "name": "İnsân",
      "arabicName": "سُورَةُ الإنسان",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ إِحْدَى وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 77,
      "name": "Mürselât",
      "arabicName": "سُورَةُ المُرسَلات",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسُونَ آيَةً"
    },
    {
      "number": 78,
      "name": "Nebe'",
      "arabicName": "سُورَةُ النـَّبأ",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعُونَ آيَةً"
    },
    {
      "number": 79,
      "name": "Nâzi'ât",
      "arabicName": "سُورَةُ النـّازِعات",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتٌّ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 80,
      "name": "Abese",
      "arabicName": "سُورَةُ عَبَس",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَأَرْبَعُونَ آيَةً"
    },
    {
      "number": 81,
      "name": "Tekvîr",
      "arabicName": "سُورَةُ التـَّكْوير",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 82,
      "name": "İnfitâr",
      "arabicName": "سُورَةُ الإنفِطار",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعَةَ عَشَرَ آيَةً"
    },
    {
      "number": 83,
      "name": "Mutaffifîn",
      "arabicName": "سُورَةُ المُطـَفِّفين",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتٌّ وَثَلَاثُونَ آيَةً"
    },
    {
      "number": 84,
      "name": "İnşikâk",
      "arabicName": "سُورَةُ الإنشِقاق",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 85,
      "name": "Bürûc",
      "arabicName": "سُورَةُ البُروج",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ اثْنَتَانِ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 86,
      "name": "Târık",
      "arabicName": "سُورَةُ الطّارق",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سَبْعَةَ عَشَرَ آيَةً"
    },
    {
      "number": 87,
      "name": "A'lâ",
      "arabicName": "سُورَةُ الأعلی",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعَةَ عَشَرَ آيَةً"
    },
    {
      "number": 88,
      "name": "Ğâşiye",
      "arabicName": "سُورَةُ الغاشِيَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتَّةٌ وَعِشْرُونَ آيَةً"
    },
    {
      "number": 89,
      "name": "Fecr",
      "arabicName": "سُورَةُ الفَجْر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثُونَ آيَةً"
    },
    {
      "number": 90,
      "name": "Beled",
      "arabicName": "سُورَةُ البَـلـَد",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ عِشْرُونَ آيَةً"
    },
    {
      "number": 91,
      "name": "Şems",
      "arabicName": "سُورَةُ الشــَّمْس",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسَةَ عَشَرَ آيَةً"
    },
    {
      "number": 92,
      "name": "Leyl",
      "arabicName": "سُورَةُ اللـَّيل",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ إِحْدَى وَعِشْرُونَ آيَةً"
    },
    {
      "number": 93,
      "name": "Duhâ",
      "arabicName": "سُورَةُ الضُّحی",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ إِحْدَى عَشَرَ آيَةً"
    },
    {
      "number": 94,
      "name": "İnşirâh",
      "arabicName": "سُورَةُ الشَّرْح",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانِ آيَاتٍ"
    },
    {
      "number": 95,
      "name": "Tîn",
      "arabicName": "سُورَةُ التـِّين",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانِ آيَاتٍ"
    },
    {
      "number": 96,
      "name": "Alâk",
      "arabicName": "سُورَةُ العَلـَق",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعَةَ عَشَرَ آيَةً"
    },
    {
      "number": 97,
      "name": "Kadr",
      "arabicName": "سُورَةُ القـَدر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسُ آيَاتٍ"
    },
    {
      "number": 98,
      "name": "Beyyine",
      "arabicName": "سُورَةُ البَيِّنَة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانِ آيَاتٍ"
    },
    {
      "number": 99,
      "name": "Zilzâl",
      "arabicName": "سُورَةُ الزلزَلة",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَمَانِ آيَاتٍ"
    },
    {
      "number": 100,
      "name": "Âdiyât",
      "arabicName": "سُورَةُ العَادِيات",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ إِحْدَى عَشَرَ آيَةً"
    },
    {
      "number": 101,
      "name": "Kâri'a",
      "arabicName": "سُورَةُ القارِعَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ إِحْدَى عَشَرَ آيَةً"
    },
    {
      "number": 102,
      "name": "Tekâsür",
      "arabicName": "سُورَةُ التَكاثـُر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَمَانِ آيَاتٍ"
    },
    {
      "number": 103,
      "name": "Asr",
      "arabicName": "سُورَةُ العَصْر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثُ آيَاتٍ"
    },
    {
      "number": 104,
      "name": "Hümeze",
      "arabicName": "سُورَةُ الهُمَزَة",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ تِسْعُ آيَاتٍ"
    },
    {
      "number": 105,
      "name": "Fîl",
      "arabicName": "سُورَةُ الفِيل",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسُ آيَاتٍ"
    },
    {
      "number": 106,
      "name": "Kureyş",
      "arabicName": "سُورَةُ قـُرَيْش",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعُ آيَاتٍ"
    },
    {
      "number": 107,
      "name": "Mâ'un",
      "arabicName": "سُورَةُ المَاعُون",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سَبْعُ آيَاتٍ"
    },
    {
      "number": 108,
      "name": "Kevser",
      "arabicName": "سُورَةُ الكَوْثَر",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ ثَلَاثُ آيَاتٍ"
    },
    {
      "number": 109,
      "name": "Kâfirûn",
      "arabicName": "سُورَةُ الكَافِرُون",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ سِتُّ آيَاتٍ"
    },
    {
      "number": 110,
      "name": "Nasr",
      "arabicName": "سُورَةُ النـَّصر",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ ثَلَاثُ آيَاتٍ"
    },
    {
      "number": 111,
      "name": "Tebbet",
      "arabicName": "سُورَةُ المَسَد",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ خَمْسُ آيَاتٍ"
    },
    {
      "number": 112,
      "name": "İhlâs",
      "arabicName": "سُورَةُ الإخْلَاص",
      "type": "مَكِّيَّة",
      "ayatCount": "وَهىَ أَرْبَعُ آيَاتٍ"
    },
    {
      "number": 113,
      "name": "Felâk",
      "arabicName": "سُورَةُ الفَلَق",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ خَمْسُ آيَاتٍ"
    },
    {
      "number": 114,
      "name": "Nas",
      "arabicName": "سُورَةُ النَّاس",
      "type": "مَدَنِيَّة",
      "ayatCount": "وَهىَ سِتُّ آيَاتٍ"
    },
  ];

  List<String> get surahNames =>
      surahInfo.map((info) => info["name"] as String).toList();

  List<String> get arabicSurahNames =>
      surahInfo.map((info) => info["arabicName"] as String).toList();

  Map<String, dynamic> getSurahInfo(int number) {
    return surahInfo.firstWhere(
      (info) => info["number"] == number,
      orElse: () => {
        "number": 0,
        "name": "Unknown",
        "arabicName": "غير معروف",
        "type": "غير معروف",
        "ayatCount": "غير معروف"
      },
    );
  }

@action
Future<List<Map<String, dynamic>>> fetchAyahByPage(int pageNumber) async {
  try {
    pageContent = await _databaseHelper.getAyahByPage(pageNumber);
    currentPage = pageNumber;
    if (pageContent.isNotEmpty) {
      juzNumber = pageContent.first['Cuz'];
    }
    return pageContent;
  } catch (e) {
    print("Error fetching ayah by page: $e");
    return [];
  }
}

  @action
  Future<void> fetchAyahAndTranslationBySurah(int surahNumber) async {
    try {
      currentSurah = surahNumber;
      ayahList = await _databaseHelper.getAyahAndTranslationBySurah(
          surahNumber, selectedLanguage);
      if (ayahList.isNotEmpty) {
        currentAyah = ayahList.first['Ayet'];
      }
    } catch (e) {
      print("Error fetching ayah and translation: $e");
    }
  }

  @action
  Future<void> searchByArabicText(String searchText) async {
    ayahList = await _databaseHelper.searchByArabicText(
        searchText, selectedLanguage);
  }

  @action
  Future<void> searchByTranslation(String searchText) async {
    ayahList =
        await _databaseHelper.searchByTranslation(searchText, selectedLanguage);
  }

  @action
  Future<void> searchByTranscript(String searchText) async {
    ayahList = await _databaseHelper.searchByTranscript(searchText);
  }

  @action
  Future<int> getPageForSurah(int surahNumber) async {
    return await _databaseHelper.getFirstPageOfSurah(surahNumber);
  }

  @action
  void changeLanguage(String language) {
    selectedLanguage = language;
    fetchAyahAndTranslationBySurah(currentSurah);
  }

  @action
  void toggleTranscript() {
    showTranscript = !showTranscript;
  }
}