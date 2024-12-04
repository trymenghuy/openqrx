import 'package:openqrx/app/util/print.dart';

String unichr(dynamic codePoint) {
  if (codePoint is int) {
    return String.fromCharCode(codePoint);
  } else if (codePoint is List<int>) {
    return String.fromCharCodes(codePoint);
  }
  return codePoint.toString();
}

const khmerStateTable = [
  [1, 2, 2, 2, 1, 1, 1, 6, 1, 1, 1, 2],
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 3, 4, 5, 6, 16, 17, 1, -1],
  [-1, -1, -1, -1, -1, 4, -1, -1, 16, -1, -1, -1],
  [-1, -1, -1, -1, 15, -1, -1, 6, 16, 17, 1, 14],
  [-1, -1, -1, -1, -1, -1, -1, -1, 20, -1, 1, -1],
  [-1, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 12, 13, -1, 10, 16, 17, 1, 14],
  [-1, -1, -1, -1, 12, 13, -1, -1, 16, 17, 1, 14],
  [-1, -1, -1, -1, 12, 13, -1, 10, 16, 17, 1, 14],
  [-1, 11, 11, 11, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 15, -1, -1, -1, 16, 17, 1, 14],
  [-1, -1, -1, -1, -1, 13, -1, -1, 16, -1, -1, -1],
  [-1, -1, -1, -1, 15, -1, -1, -1, 16, 17, 1, 14],
  [-1, -1, -1, -1, -1, -1, -1, -1, 16, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1, 16, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, 17, 1, 18],
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 18],
  [-1, -1, -1, -1, -1, -1, -1, 19, -1, -1, -1, -1],
  [-1, 1, -1, 1, -1, -1, -1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1]
];

final SRAAA = unichr(0x17b6);
final SRAE = unichr(0x17c1);
final SRAOE = unichr(0x17be);
final SRAOO = unichr(0x17c4);
final SRAYA = unichr(0x17bf);
final SRAIE = unichr(0x17c0);
final SRAAU = unichr(0x17c5);
final SRAII = unichr(0x17b8);
final SRAU = unichr(0x17bb);
final TRIISAP = unichr(0x17ca);
final MUUSIKATOAN = unichr(0x17c9);
final SAMYOKSANNYA = unichr(0x17d0);
final LA = unichr(0x17a1);
final NYO = unichr(0x1789);
final BA = unichr(0x1794);
final YO = unichr(0x1799);
final SA = unichr(0x179f);
final COENG = unichr(0x17d2);
final CORO = unichr(0x17d2) + unichr(0x179a);
final CONYO = unichr(0x17d2) + unichr(0x1789);
final SRAOM = unichr(0x17c6);

final MARK = unichr(0x17ea);
const DOTCIRCLE = "";

final sraEcombining = {
  SRAOE: SRAII,
  SRAYA: SRAYA,
  SRAIE: SRAIE,
  SRAOO: SRAAA,
  SRAAU: SRAAU,
};

const ccReserved = 0;
const ccConsonant = 1;
const ccConsonant2 = 2;
const ccConsonant3 = 3;
const ccZeroWidthNjMark = 4;
const ccConsonantShifter = 5;
const ccRobat = 6;
const ccCoeng = 7;
const ccDependentVowel = 8;
const ccSignAbove = 9;
const ccSignAfter = 10;
const ccZeroWidthJMark = 11;
const ccCount = 12;

const cfClassMask = 0x0000ffff;
const cfConsonant = 0x01000000;
const cfSplitVowel = 0x02000000;
const cfDottedCircle = 0x04000000;
const cfCoeng = 0x08000000;
const cfShifter = 0x10000000;
const cfAboveVowel = 0x20000000;
const cfPosBefore = 0x00080000;
const cfPosBelow = 0x00040000;
const cfPosAbove = 0x00020000;
const cfPosAfter = 0x00010000;
const cfPosMask = 0x000f0000;
const xx = ccReserved;
const sa = ccSignAbove | cfDottedCircle | cfPosAbove;
const sp = ccSignAfter | cfDottedCircle | cfPosAfter;
const c1 = ccConsonant | cfConsonant;
const c2 = ccConsonant2 | cfConsonant;
const c3 = ccConsonant3 | cfConsonant;
const rb = ccRobat | cfPosAbove | cfDottedCircle;
const cs = ccConsonantShifter | cfDottedCircle | cfShifter;
const dl = ccDependentVowel | cfPosBefore | cfDottedCircle;
const db = ccDependentVowel | cfPosBelow | cfDottedCircle;
const da = ccDependentVowel | cfPosAbove | cfDottedCircle | cfAboveVowel;
const dr = ccDependentVowel | cfPosAfter | cfDottedCircle;
const co = ccCoeng | cfCoeng | cfDottedCircle;

const va = da | cfSplitVowel;
const vr = dr | cfSplitVowel;
const khmerCharClasses = [
  c1,
  c1,
  c1,
  c3,
  c1,
  c1,
  c1,
  c1,
  c3,
  c1,
  c1,
  c1,
  c1,
  c3,
  c1,
  c1, // 1780 - 178F
  c1,
  c1,
  c1,
  c1,
  c3,
  c1,
  c1,
  c1,
  c1,
  c3,
  c2,
  c1,
  c1,
  c1,
  c3,
  c3, // 1790 - 179F
  c1,
  c3,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1,
  c1, // 17A0 - 17AF
  c1,
  c1,
  c1,
  c1,
  dr,
  dr,
  dr,
  da,
  da,
  da,
  da,
  db,
  db,
  db,
  va,
  vr, // 17B0 - 17BF
  vr,
  dl,
  dl,
  dl,
  vr,
  vr,
  sa,
  sp,
  sp,
  cs,
  cs,
  sa,
  rb,
  sa,
  sa,
  sa, // 17C0 - 17CF
  sa,
  sa,
  co,
  sa,
  xx,
  xx,
  xx,
  xx,
  xx,
  xx,
  xx,
  xx,
  xx,
  sa,
  xx,
  xx, // 17D0 - 17DF
];

final List<List<dynamic>> limonReplacers = [
  [0x30, "០"],
  [0x31, "១"],
  [0x32, "២"],
  [0x33, "៣"],
  [0x34, "៤"],
  [0x35, "៥"],
  [0x36, "៦"],
  [0x37, "៧"],
  [0x38, "៨"],
  [0x39, "៩"],
  [0x2b, "៎"],
  [0x2c, "\u17D2ប"],
  [0x3c, "\u17D2ព"],
  [0x41, "ៅ"],
  [0x42, "ព"],
  [0x43, "ជ"],
  [0x44, "ឌ"],
  [0x45, "ែ"],
  [0x46, "ធ"],
  [0x47, "អ"],
  [0x49, "ី"],
  [0x4a, "\u17D2ញ"],
  [0x4b, "គ"],
  [0x4d, "ំ"],
  [0x4e, "ណ"],
  [0x4f, "ឿ"],
  [0x50, "ភ"],
  [0x51, "ឈ"],
  [0x52, "\u17D2រ"],
  [0x54, "ទ"],
  [0x55, "ូ"],
  [0x56, "\u17D2វ"],
  [0x57, "ឺ"],
  [0x58, "ឃ"],
  [0x59, "ួ"],
  [0x5a, "ឍ"],
  [0x5f, "៍"],
  [0x61, "ា"],
  [0x62, "ប"],
  [0x63, "ច"],
  [0x64, "ដ"],
  [0x65, "េ"],
  [0x66, "ថ"],
  [0x67, "ង"],
  [0x68, "ហ"],
  [0x69, "ិ"],
  [0x6a, "ញ"],
  [0x6b, "ក"],
  [0x6c, "ល"],
  [0x6d, "ម"],
  [0x6e, "ន"],
  [0x6f, "ៀ"],
  [0x70, "ផ"],
  [0x71, "ឆ"],
  [0x72, "រ"],
  [0x73, "ស"],
  [0x74, "ត"],
  [0x75, "ុ"],
  [0x76, "វ"],
  [0x77, "ឹ"],
  [0x78, "ខ"],
  [0x79, "យ"],
  [0x7a, "ឋ"],
  [0xa2, "\u17D2ជ"],
  [0xa7, "\u17D2ធ"],
  [0xa9, "\u17D2ច"],
  [0xb5, "\u17D2ម"],
  [0xb6, "\u17D2ង"],
  [0xbe, "៏"],
  [0xc4, "\u17D2ឈ"],
  [0xc6, "\u17D2ឍ"],
  [0xc7, "\u17D2ឃ"],
  [0xc9, "ឯ"],
  [0xd0, "\u17D2ឌ"],
  [0xd1, "\u17D2ណ"],
  [0xd6, "\u17D2ភ"],
  [0xde, "\u17D2ទ"],
  [0xe4, "\u17D2ឆ"],
  [0xe6, "\u17D2ឋ"],
  [0xe7, "\u17D2ខ"],
  [0xe9, "ៃ"],
  [0xf1, "\u17D2ន"],
  [0xf6, "\u17D2ផ"],
  [0xf8, "\u17D2ល"],
  [0xfc, "\u17D2យ"],
  [0xfe, "\u17D2ត"],
  [
    [0x42, 0xa7],
    "ឰ"
  ],
  [
    [0x47, 0x61],
    "អា"
  ],
  [
    [0x2e, 0x6c, 0x2e],
    "៘"
  ],
  //
  [0xae, "\u17EA\u17D2រ"],
  [0xc5, "\u17EAឺ"],
  [0xcd, "\u17EAី"],
  [0xd3, "\u17EAឿ"],
  [0xd8, "\u17EA\u17D2ញ"],
  [0xda, "\u17EAូ"],
  [0xdc, "\u17EAួ"],
  [0xe5, "\u17EAឹ"],
  [0xed, "\u17EAិ"],
  [0xf3, "\u17EAៀ"],
  [0xfa, "\u17EAុ"],
  [0x47, "\u17a3"],
  [
    [0x42, 0x61],
    "\u17EAញ"
  ],
  [0x75, "\u17EA៉"],
  [0x75, "\u17EA៊"],
  [0xfa, "\u17EA\u17EA៊"],
  [0xfa, "\u17EA\u17EA៉"],

  // limon parent
  [0x21, "1"],
  [0x23, "3"],
  [0x24, "4"],
  [0x25, "5"],
  [0x26, "7"],
  [0x28, "9"],
  [
    [0x29, 0x61],
    "បា"
  ],
  [
    [0x29, 0x41],
    "បៅ"
  ],
  [0x2a, "8"],
  [0x2e, "។"],
  [0x3a, "៉"],
  [0x3d, "="],
  [0x3e, "."],
  [0x40, "2"],
  [0x48, "ះ"],
  [0x4c, "ឡ"],
  [0x53, "\u17D2ស"],
  [0x5c, "ឥ"],
  [0x5d, "ឧ"],
  [0x5e, "6"],
  [0x7b, "\u201c"],
  [0x7c, "ឦ"],
  [0x7d, "\u201d"],
  [0x2018, "៊"],
  [0x2019, "៌"],
  [0xa1, "!"],
  [0xa5, "\u17D2អ"],
  [0xab, "ឪ"],
  [0xb2, "ៗ"],
  [0xb3, "ៈ"],
  [0xb9, "៛"],
  [0xbb, "ឱ"],
  [0xbd, "័"],
  [0xc1, "\u17D2គ"],
  [0xd7, "ិ៍"],
  [0xdf, "\u17D2ថ"],
  [0xe1, "\u17D2ក"],
  [0xf0, "\u17D2ហ"],
  [0xf7, "+"],
  [
    [0x5d, 0x5f],
    "ឳ"
  ],
  [
    [0x5d, 0x75],
    "ឩ"
  ],
  [
    [0x42, 0xa3],
    "ឭ"
  ],
  [
    [0x62, 0xa3],
    "ឫ"
  ],
  [
    [0x42, 0xa4],
    "ឮ"
  ],
  [
    [0x62, 0xa4],
    "ឬ"
  ],

  [0xb3, "៖"],
  [0xbf, "\u17EAំ"],

  // limon s1
  [0x3b, "់"],
  [0x5b, "ឱ\u17d2យ"],
  [0xa6, ")"],
  [0xac, "("],
  [0xb0, "%"],
  [0xb4, "ខ\u17d2ញុំ"],
  [0xbc, "/"],
  [
    [0x5d, 0x2018],
    "ឨ"
  ],

  [0x2e, "៕"],
  [0x5b, "ឲ\u17d2យ"],
  [0xb4, "ខ\u17d2ញ\u17EAុំ"],
  [0xbb, "ឲ"],
  [0xfe, "\u17d2ដ"],
];

class UniLimon {
  static int getCharClass(String uniChar) {
    int ch = ord(uniChar[0]);
    if (ch >= 0x1780) {
      ch -= 0x1780;
      if (ch < khmerCharClasses.length) {
        return khmerCharClasses[ch];
      }
    }
    return 0;
  }

  static int ord(String c) {
    if (c.length != 1) {
      throw ArgumentError('Input must be a string of length 1');
    }
    return c.codeUnitAt(0);
  }

  static String reorder(String sin) {
    int cursor = 0;
    int state = 0;
    int charCount = sin.length;
    String result = "";

    while (cursor < charCount) {
      String reserved = "";
      String signAbove = "";
      String signAfter = "";
      String base = "";
      String robat = "";
      String shifter = "";
      String vowelBefore = "";
      String vowelBelow = "";
      String vowelAbove = "";
      String vowelAfter = "";
      bool coeng = false;
      String cluster = "";
      String coeng1 = "";
      String coeng2 = "";
      bool shifterAfterCoeng = false;

      while (cursor < charCount) {
        String curChar = sin[cursor];
        int kChar = getCharClass(curChar);
        int charClass = kChar & cfClassMask;
        state = khmerStateTable[state][charClass];
        if (state < 0) break;

        // collect variable for cluster here
        if (kChar == xx) {
          reserved = curChar;
        } else if (kChar == sa) {
          // Sign placed above the base
          signAbove = curChar;
        } else if (kChar == sp) {
          // Sign placed after the base
          signAfter = curChar;
        } else if (kChar == c1 || kChar == c2 || kChar == c3) {
          if (coeng) {
            // Consonant
            if (coeng1.isEmpty) {
              coeng1 = COENG + curChar;
            } else {
              coeng2 = COENG + curChar;
            }
            coeng = false;
          } else {
            base = curChar;
          }
        } else if (kChar == rb) {
          // Khmer sign robat u17CC
          robat = curChar;
        } else if (kChar == cs) {
          // Consonant-shifter
          if (coeng1.isNotEmpty) shifterAfterCoeng = true;
          shifter = curChar;
        } else if (kChar == dl) {
          // Dependent vowel placed before the base
          vowelBefore = curChar;
        } else if (kChar == db) {
          // Dependent vowel placed below the base
          vowelBelow = curChar;
        } else if (kChar == da) {
          // Dependent vowel placed above the base
          vowelAbove = curChar;
        } else if (kChar == dr) {
          // Dependent vowel placed behind the base
          vowelAfter = curChar;
        } else if (kChar == co) {
          // Khmer combining mark COENG
          coeng = true;
        } else if (kChar == va) {
          // Khmer split vowel, see da
          vowelBefore = SRAE;
          vowelAbove = sraEcombining[curChar]!;
        } else if (kChar == vr) {
          // Khmer split vowel, see dr
          vowelBefore = SRAE;
          vowelAfter = sraEcombining[curChar]!;
        }
        cursor += 1;
      }

      // logic of vowel
      // determine if right side vowel should be marked
      if (coeng1.isNotEmpty && vowelBelow.isNotEmpty) {
        vowelBelow = MARK + vowelBelow;
      } else if ((base == LA || base == NYO) && vowelBelow.isNotEmpty) {
        vowelBelow = MARK + vowelBelow;
      } else if (coeng1.isNotEmpty &&
          vowelBefore.isNotEmpty &&
          vowelAfter.isNotEmpty) {
        vowelAfter = MARK + vowelAfter;
      }

      // logic when cluster has coeng
      // should coeng be located on left side
      String coengBefore = "";
      if (coeng1 == CORO) {
        coengBefore = coeng1;
        coeng1 = "";
      } else if (coeng2 == CORO) {
        coengBefore = MARK + coeng2;
        coeng2 = "";
      }

      if (coeng1.isNotEmpty || coeng2.isNotEmpty) {
        // NYO must change to other form when there is coeng
        if (base == NYO) {
          base = MARK + base;
          // coeng NYO must be marked
          if (coeng1 == CONYO) coeng1 = MARK + coeng1;
        }
        if (coeng1.isNotEmpty && coeng2.isNotEmpty) coeng2 = MARK + coeng2;
      }

      // logic of shifter with base character
      if (base.isNotEmpty && shifter.isNotEmpty) {
        // special case apply to BA only
        if (vowelAbove.isNotEmpty && base == BA && shifter == TRIISAP) {
          vowelAbove = MARK + vowelAbove;
        } else if (vowelAbove.isNotEmpty) {
          shifter = MARK + shifter;
        } else if (signAbove == SAMYOKSANNYA && shifter == MUUSIKATOAN) {
          shifter = MARK + shifter;
        } else if (signAbove.isNotEmpty && vowelAfter.isNotEmpty) {
          shifter = MARK + shifter;
        } else if (signAbove.isNotEmpty) {
          signAbove = MARK + signAbove;
        }
        // add another mark to shifter
        if (coeng1.isNotEmpty &&
            (vowelAbove.isNotEmpty || signAbove.isNotEmpty)) {
          shifter = MARK + shifter;
        }
        if (base == LA || base == NYO) shifter = MARK + shifter;
      }

      // uncomplete coeng
      if (coeng && coeng1.isEmpty) {
        coeng1 = COENG;
      } else if (coeng && coeng2.isEmpty) {
        coeng2 = MARK + COENG;
      }

      // render DOTCIRCLE for standalone sign or vowel
      if (base.isEmpty &&
          (vowelBefore.isNotEmpty ||
              coengBefore.isNotEmpty ||
              robat.isNotEmpty ||
              shifter.isNotEmpty ||
              coeng1.isNotEmpty ||
              coeng2.isNotEmpty ||
              vowelAfter.isNotEmpty ||
              vowelBelow.isNotEmpty ||
              vowelAbove.isNotEmpty ||
              signAbove.isNotEmpty ||
              signAfter.isNotEmpty)) {
        base = DOTCIRCLE;
      }

      // place of shifter
      String shifter1 = "";
      String shifter2 = "";

      if (shifterAfterCoeng) {
        shifter2 = shifter;
      } else {
        shifter1 = shifter;
      }

      bool specialCaseBA = false;
      if (base == BA &&
          (vowelAfter == SRAAA ||
              vowelAfter == SRAAU ||
              vowelAfter == MARK + SRAAA ||
              vowelAfter == MARK + SRAAU)) {
        // SRAAA or SRAAU will get a MARK if there is coeng, redefine to last char
        vowelAfter = vowelAfter[vowelAfter.length - 1];
        specialCaseBA = true;
        if (coeng1.isNotEmpty &&
            [BA, YO, SA].contains(coeng1[coeng1.length - 1])) {
          specialCaseBA = false;
        }
      }

      // cluster formation
      if (specialCaseBA) {
        cluster = vowelBefore +
            coengBefore +
            base +
            vowelAfter +
            robat +
            shifter1 +
            coeng1 +
            coeng2 +
            shifter2 +
            vowelBelow +
            vowelAbove +
            signAbove +
            signAfter;
      } else {
        cluster = vowelBefore +
            coengBefore +
            base +
            robat +
            shifter1 +
            coeng1 +
            coeng2 +
            shifter2 +
            vowelBelow +
            vowelAbove +
            vowelAfter +
            signAbove +
            signAfter;
      }
      result += cluster + reserved;
      state = 0;
    }
    return result;
  }

  static String limon(String text) {
    text = reorder(text);

    for (var replacement in limonReplacers) {
      String from = replacement[1];
      String to = unichr(replacement[0]);
      if (from.contains("\u17d2")) {
        text = text.replaceAll(from, to);
      }
    }

    for (var replacement in limonReplacers.reversed) {
      String from = replacement[1];
      String to = unichr(replacement[0]);
      if (!from.contains("\u17d2")) {
        text = text.replaceAll(from, to);
      }
    }
    xPrint(text);
    return text.replaceAll(RegExp('\u17ea'), '');
  }
}
