import 'package:openqrx/app/util/print.dart';

class UnicodeHelper {
  static String test(String input) {
    final SRAAA = String.fromCharCode(0x17B6);
    final SRAE = String.fromCharCode(0x17C1);
    final SRAOE = String.fromCharCode(0x17BE);
    final SRAOO = String.fromCharCode(0x17C4);
    final SRAYA = String.fromCharCode(0x17BF);
    final SRAIE = String.fromCharCode(0x17C0);
    final SRAAU = String.fromCharCode(0x17C5);
    final SRAII = String.fromCharCode(0x17B8);
    final SRAU = String.fromCharCode(0x17BB);
    final TRIISAP = String.fromCharCode(0x17CA);
    final MUUSIKATOAN = String.fromCharCode(0x17C9);
    final SAMYOKSANNYA = String.fromCharCode(0x17D0);

    final LA = String.fromCharCode(0x17A1);
    final NYO = String.fromCharCode(0x1789);
    final BA = String.fromCharCode(0x1794);
    final YO = String.fromCharCode(0x1799);
    final SA = String.fromCharCode(0x179F);
    final COENG = String.fromCharCode(0x17D2);
    final CORO = String.fromCharCode(0x17D2) + String.fromCharCode(0x179A);
    final CONYO = String.fromCharCode(0x17D2) + String.fromCharCode(0x1789);
    final SRAOM = String.fromCharCode(0x17C6);

    final MARK = String.fromCharCode(0x17EA);
    const DOTCIRCLE = '';

    final sraEcombining = {
      SRAOE: SRAII,
      SRAYA: SRAYA,
      SRAIE: SRAIE,
      SRAOO: SRAAA,
      SRAAU: SRAAU
    };

// Character Classes
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

// Character Flags
    const cfClassMask = 0x0000FFFF;
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
    const cfPosMask = 0x000F0000;

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
      c1, c1, c1, c3, c1, c1, c1, c1, c3, c1, c1, c1, c1, c3, c1,
      c1, // 1780 - 178F
      c1, c1, c1, c1, c3, c1, c1, c1, c1, c3, c2, c1, c1, c1, c3,
      c3, // 1790 - 179F
      c1, c3, c1, c1, c1, c1, c1, c1, c1, c1, c1, c1, c1, c1, c1,
      c1, // 17A0 - 17AF
      c1, c1, c1, c1, dr, dr, dr, da, da, da, da, db, db, db, va,
      vr, // 17B0 - 17BF
      vr, dl, dl, dl, vr, vr, sa, sp, sp, cs, cs, sa, rb, sa, sa,
      sa, // 17C0 - 17CF
      sa, sa, co, sa, xx, xx, xx, xx, xx, xx, xx, xx, xx, sa, xx,
      xx, // 17D0 - 17DF
    ];

    const khmerStateTable = [
      // xx  c1  c2  c3 zwnj cs  rb  co  dv  sa  sp zwj
      [1, 2, 2, 2, 1, 1, 1, 6, 1, 1, 1, 2], //  0 - ground state
      [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], //  1 - exit state
      [-1, -1, -1, -1, 3, 4, 5, 6, 16, 17, 1, -1], //  2 - Base consonant
      [
        -1,
        -1,
        -1,
        -1,
        -1,
        4,
        -1,
        -1,
        16,
        -1,
        -1,
        -1
      ], //  3 - First ZWNJ before register shifter
      [
        -1,
        -1,
        -1,
        -1,
        15,
        -1,
        -1,
        6,
        16,
        17,
        1,
        14
      ], //  4 - First register shifter
      [-1, -1, -1, -1, -1, -1, -1, -1, 20, -1, 1, -1], //  5 - Robat
      [-1, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, -1], //  6 - First Coeng
      [
        -1,
        -1,
        -1,
        -1,
        12,
        13,
        -1,
        10,
        16,
        17,
        1,
        14
      ], //  7 - First consonant of type 1 after coeng
      [
        -1,
        -1,
        -1,
        -1,
        12,
        13,
        -1,
        -1,
        16,
        17,
        1,
        14
      ], //  8 - First consonant of type 2 after coeng
      [
        -1,
        -1,
        -1,
        -1,
        12,
        13,
        -1,
        10,
        16,
        17,
        1,
        14
      ], //  9 - First consonant or type 3 after coeng
      [-1, 11, 11, 11, -1, -1, -1, -1, -1, -1, -1, -1], // 10 - Second Coeng
      [
        -1,
        -1,
        -1,
        -1,
        15,
        -1,
        -1,
        -1,
        16,
        17,
        1,
        14
      ], // 11 - Second coeng consonant
      [
        -1,
        -1,
        -1,
        -1,
        -1,
        13,
        -1,
        -1,
        16,
        -1,
        -1,
        -1
      ], // 12 - First ZWNJ after coeng consonant
      [
        -1,
        -1,
        -1,
        -1,
        15,
        -1,
        -1,
        -1,
        16,
        -1,
        1,
        14
      ], // 13 - Second register shifter
      [-1, -1, -1, -1, -1, -1, -1, 6, -1, -1, -1, -1], // 14 - First Zwj
      [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        16,
        -1,
        -1,
        -1
      ], // 15 - First ZWJ after register shifter
      [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1], // 16 - Dependent vowel
      [-1, -1, -1, -1, -1, -1, -1, -1, 18, -1, 1, -1], // 17 - Sign Above
      [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, -1], // 18 - Sign After
      [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        6,
        -1,
        -1,
        -1,
        -1
      ], // 19 - First Zwj after sign above
      [
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1,
        -1
      ], // 20 - Dependent vowel after register shifter
    ];

    bool validate(
        List<int> charClasses, List<List<int>> stateTable, String input) {
      int state = 0;
      for (int i = 0; i < input.length; i++) {
        int charClass = charClasses[input.codeUnitAt(i)];
        state = stateTable[state][charClass];
        if (state == -1) return false;
      }
      return true;
    }
    // String input = "ខ្ញុំស្រលាញ់ប្រទេសកម្ពុជា";

    var isValid = validate(khmerCharClasses, khmerStateTable, input);
    xPrint(isValid);
    return input;
  }

  static String? limonToUnicode(String? a) {
    if (a == null || a.isEmpty) return null;
    a = a
        .replaceAll('1', '១')
        .replaceAll('2', '២')
        .replaceAll('3', '៣')
        .replaceAll('4', '៤')
        .replaceAll('5', '៥')
        .replaceAll('6', '៦')
        .replaceAll('7', '៧')
        .replaceAll('8', '៨')
        .replaceAll('9', '៩')
        .replaceAll('0', '០');

    // Consonants
    a = a
        .replaceAll('BaØ', 'ញ្ញ')
        .replaceAll('k', 'ក')
        .replaceAll('x', 'ខ')
        .replaceAll('K', 'គ')
        .replaceAll('X', 'ឃ')
        .replaceAll('g', 'ង')
        .replaceAll('c', 'ច')
        .replaceAll('q', 'ឆ')
        .replaceAll('C', 'ជ')
        .replaceAll('Q', 'ឈ')
        .replaceAll('j', 'ញ')
        .replaceAll('d', 'ដ')
        .replaceAll('f', 'ថ')
        .replaceAll('D', 'ឌ')
        .replaceAll('F', 'ធ')
        .replaceAll('n', 'ន')
        .replaceAll('t', 'ត')
        .replaceAll('z', 'ឋ')
        .replaceAll('T', 'ទ')
        .replaceAll('Z', 'ឍ')
        .replaceAll('N', 'ណ')
        .replaceAll('b', 'ប')
        .replaceAll('p', 'ផ')
        .replaceAll('B', 'ព')
        .replaceAll('P', 'ភ')
        .replaceAll('m', 'ម')
        .replaceAll('y', 'យ')
        .replaceAll('r', 'រ')
        .replaceAll('l', 'ល')
        .replaceAll('v', 'វ')
        .replaceAll('s', 'ស')
        .replaceAll('h', 'ហ')
        .replaceAll('L', 'ឡ')
        .replaceAll('G', 'អ');

    // Subscripts
    a = a
        .replaceAll('á', '្ក')
        .replaceAll('ç', '្ខ')
        .replaceAll('Á', '្គ')
        .replaceAll('Ç', '្ឃ')
        .replaceAll('¶', '្ង')
        .replaceAll('©', '្ច')
        .replaceAll('ä', '្ឆ')
        .replaceAll('¢', '្ជ')
        .replaceAll('Ä', '្ឈ')
        .replaceAll('J', '្ញ')
        .replaceAll('þ', '្ដ')
        .replaceAll('ß', '្ថ')
        .replaceAll('Ð', '្ឌ')
        .replaceAll('§', '្ធ')
        .replaceAll('ñ', '្ន')
        .replaceAll('þ', '្ត')
        .replaceAll('æ', '្ឋ')
        .replaceAll('Þ', '្ទ')
        .replaceAll('Æ', '្ឍ')
        .replaceAll('Ñ', '្ណ')
        .replaceAll(',', '្ប')
        .replaceAll('ö', '្ផ')
        .replaceAll('<', '្ព')
        .replaceAll('Ö', '្ភ')
        .replaceAll('µ', '្ម')
        .replaceAll('ü', '្យ')
        .replaceAll('R', '្រ')
        .replaceAll('ø', '្ល')
        .replaceAll('V', '្វ')
        .replaceAll('S', '្ស')
        .replaceAll('ð', '្ហ')
        .replaceAll('¥', '្អ');

    // Taller subscripts
    a = a
        .replaceAll('ú', 'ុ')
        .replaceAll('Ú', 'ូ')
        .replaceAll('Ü', 'ួ')
        .replaceAll('Í', 'ី')
        .replaceAll('å', 'ឹ')
        .replaceAll('í', 'ិ')
        .replaceAll('Å', 'ឺ')
        .replaceAll('Ø', '្ញ')
        .replaceAll('¿', 'ំ');

    // Some vowels
    a = a
        .replaceAll('a', 'ា')
        .replaceAll('i', 'ិ')
        .replaceAll('I', 'ី')
        .replaceAll('w', 'ឹ')
        .replaceAll('W', 'ឺ')
        .replaceAll('u', 'ុ')
        .replaceAll('U', 'ូ')
        .replaceAll('Y', 'ួ')
        .replaceAll('M', 'ំ')
        .replaceAll('H', 'ះ');

    // Miscellaneous
    a = a
        .replaceAll('M', 'ំ')
        .replaceAll('³', 'ៈ')
        .replaceAll(';', '់')
        .replaceAll('²', 'ៗ')
        .replaceAll('‘', '៊')
        .replaceAll(':', '៉')
        .replaceAll('½', '័')
        .replaceAll('¾', '៏')
        .replaceAll('’', '៌')
        .replaceAll('+', '៎')
        .replaceAll('_', '៍')
        .replaceAll('×', 'ិ៍')
        .replaceAll('´', 'ខ្ញុំ')
        .replaceAll('.', '។')
        .replaceAll('¬', '(')
        .replaceAll('¦', ')')
        .replaceAll('?', '?')
        .replaceAll('{', '«')
        .replaceAll('}', '»')
        .replaceAll('°', '%')
        .replaceAll('>', '.')
        .replaceAll('/', ',')
        .replaceAll('¼', '/')
        .replaceAll('=', '=')
        .replaceAll('÷', '+')
        .replaceAll('-', '-')
        .replaceAll('¡', '!')
        .replaceAll('¹', '៛')
        .replaceAll('ប£', 'ឫ')
        .replaceAll('ប¤', 'ឬ')
        .replaceAll('ព£', 'ឭ')
        .replaceAll('ព¤', 'ឮ')
        .replaceAll('ព្ធ', 'ឰ');

    // Independent vowels
    a = a
        .replaceAll('\\', 'ឥ')
        .replaceAll('|', 'ឦ')
        .replaceAll(']', 'ឧ')
        .replaceAll('«', 'ឪ')
        .replaceAll('É', 'ឯ')
        .replaceAll('»', 'ឱ')
        .replaceAll('[', 'ឱ្យ');

    a = a
        .replaceAll('e', 'េ')
        .replaceAll('O', 'ឿ')
        .replaceAll('o', 'ៀ')
        .replaceAll('E', 'ែ')
        .replaceAll('é', 'ៃ')
        .replaceAll('ó', 'ៀ')
        .replaceAll('Ó', 'ឿ')
        .replaceAll('A', 'ៅ');

    // Miscellaneous issues
    a = a
        .replaceAll('®', '្រ')
        .replaceAll(RegExp(r'([\u17D2\u179A])(.)([\u17C0\u17BF])'), r'$2$1')
        .replaceAll(
            RegExp(r'([\u17D2\u179A])(\u17D2.)([\u17C0\u17BF])'), r'$2$1')
        .replaceAll(RegExp(r'([\u17D2\u179A])(\u17D2.\u17D2.)([\u17C0\u17BF])'),
            r'$2$1')
        .replaceAll(RegExp(r'([\u17C2\u17C3])(.)'), r'$2$1');

    // Additional logic and replacements
    // (Other replacements can be added as necessary)

    return a;
  }

  String? limon(String? input) {
    if (input == null || input.isEmpty) return null;

    final replacements = {
      // Numbers
      '1': '១', '2': '២', '3': '៣', '4': '៤', '5': '៥',
      '6': '៦', '7': '៧', '8': '៨', '9': '៩', '0': '០',

      // Consonants and special cases
      'BaØ': 'ញ្ញ', 'k': 'ក', 'x': 'ខ', 'K': 'គ', 'X': 'ឃ', 'g': 'ង',
      'c': 'ច', 'q': 'ឆ', 'C': 'ជ', 'Q': 'ឈ', 'j': 'ញ', 'd': 'ដ',
      'f': 'ថ', 'D': 'ឌ', 'F': 'ធ', 'n': 'ន', 't': 'ត', 'z': 'ឋ',
      'T': 'ទ', 'Z': 'ឍ', 'N': 'ណ', 'b': 'ប', 'p': 'ផ', 'B': 'ព',
      'P': 'ភ', 'm': 'ម', 'y': 'យ', 'r': 'រ', 'l': 'ល', 'v': 'វ',
      's': 'ស', 'h': 'ហ', 'L': 'ឡ', 'G': 'អ',

      // Subscripts and diacritics
      'á': '្ក', 'ç': '្ខ', 'Á': '្គ', 'Ç': '្ឃ', '¶': '្ង',
      '©': '្ច', 'ä': '្ឆ', '¢': '្ជ', 'Ä': '្ឈ', 'J': '្ញ',
      'ú': 'ុ', 'Ú': 'ូ', 'Ü': 'ួ', 'Í': 'ី', 'å': 'ឹ', 'í': 'ិ',
      'Å': 'ឺ', 'Ø': '្ញ', '¿': 'ំ', '³': 'ៈ', ';': '់', '²': 'ៗ',
      '‘': '៊', ':': '៉', '½': '័', '¾': '៏', '’': '៌', '+': '៎',
      '_': '៍', '×': 'ិ៍', '´': 'ខ្ញុំ',

      // Vowels
      'a': 'ា', 'i': 'ិ', 'I': 'ី', 'w': 'ឹ', 'W': 'ឺ',
      'u': 'ុ', 'U': 'ូ', 'Y': 'ួ', 'M': 'ំ', 'H': 'ះ',
      'e': 'េ', 'O': 'ឿ', 'o': 'ៀ', 'E': 'ែ', 'é': 'ៃ', 'A': 'ៅ',

      // Punctuation and symbols
      '.': '។', '¬': '(', '¦': ')', '?': '?', '{': '«', '}': '»',
      '°': '%', '>': '.', '/': ',', '¼': '/', '=': '=', '÷': '+',
      '-': '-', '¡': '!', '¹': '៛',

      // Independent vowels
      '\\': 'ឥ', '|': 'ឦ', ']': 'ឧ', '«': 'ឪ', 'É': 'ឯ', '»': 'ឱ', '[': 'ឱ្យ',
    };

    // Handle subscripts and superscripts separately to prevent incorrect order of replacements
    final subscripts = {
      'R': '្រ', // Reordering for subscript after some characters
    };

    // Use RegExp to replace all keys in the input string
    String output = input.replaceAllMapped(
        RegExp(replacements.keys.map(RegExp.escape).join('|')),
        (match) => replacements[match.group(0)] ?? match.group(0)!);

    // Apply subscripts replacements
    output = output.replaceAllMapped(
        RegExp(subscripts.keys.map(RegExp.escape).join('|')),
        (match) => subscripts[match.group(0)] ?? match.group(0)!);

    return output;
  }

  static String? fromUnicode(String? a) {
    if (a == null || a.isEmpty) {
      return null;
    }

    // Numbers
    // a = a.replaceAll('1', '១');
    // a = a.replaceAll('2', '២');
    // a = a.replaceAll('3', '៣');
    // a = a.replaceAll('4', '៤');
    // a = a.replaceAll('5', '៥');
    // a = a.replaceAll('6', '៦');
    // a = a.replaceAll('7', '៧');
    // a = a.replaceAll('8', '៨');
    // a = a.replaceAll('9', '៩');
    // a = a.replaceAll('0', '០');

    // Consonants
    a = a.replaceAll('á', 'បា');
    a = a.replaceAll('Á', 'បៅ');
    a = a.replaceAll('BaØ', 'ញ្ញ');
    a = a.replaceAll('k', 'ក');
    a = a.replaceAll('x', 'ខ');
    a = a.replaceAll('K', 'គ');
    a = a.replaceAll('X', 'ឃ');
    a = a.replaceAll('g', 'ង');
    a = a.replaceAll('c', 'ច');
    a = a.replaceAll('q', 'ឆ');
    a = a.replaceAll('C', 'ជ');
    a = a.replaceAll('Q', 'ឈ');
    a = a.replaceAll('j', 'ញ');
    a = a.replaceAll('d', 'ដ');
    a = a.replaceAll('z', 'ឋ');
    a = a.replaceAll('D', 'ឌ');
    a = a.replaceAll('Z', 'ឍ');
    a = a.replaceAll('N', 'ណ');
    a = a.replaceAll('t', 'ត');
    a = a.replaceAll('f', 'ថ');
    a = a.replaceAll('T', 'ទ');
    a = a.replaceAll('F', 'ធ');
    a = a.replaceAll('n', 'ន');
    a = a.replaceAll('b', 'ប');
    a = a.replaceAll('p', 'ផ');
    a = a.replaceAll('B', 'ព');
    a = a.replaceAll('P', 'ភ');
    a = a.replaceAll('m', 'ម');
    a = a.replaceAll('y', 'យ');
    a = a.replaceAll('r', 'រ');
    a = a.replaceAll('l', 'ល');
    a = a.replaceAll('v', 'វ');
    a = a.replaceAll('s', 'ស');
    a = a.replaceAll('h', 'ហ');
    a = a.replaceAll('L', 'ឡ');
    a = a.replaceAll('G', 'អ');

    // Subscripts
    a = a.replaceAll(';', '្ក');
    a = a.replaceAll('ç', '្ខ');
    a = a.replaceAll(':', '្គ');
    a = a.replaceAll('Ç', '្ខ');
    a = a.replaceAll('¶', '្ង');
    a = a.replaceAll('©', '្ច');
    a = a.replaceAll('ä', '្ឆ');
    a = a.replaceAll('¢', '្ជ');
    a = a.replaceAll('Ä', '្ឈ');
    a = a.replaceAll('J', '្ញ');
    a = a.replaceAll('þ', '្ដ');
    a = a.replaceAll('æ', '្ឋ');
    a = a.replaceAll('Ð', '្ឌ');
    a = a.replaceAll('Æ', '្ឍ');
    a = a.replaceAll('Ñ', '្ណ');
    a = a.replaceAll('þ', '្ត');
    a = a.replaceAll('S', '្ថ');
    a = a.replaceAll('Þ', '្ទ');
    a = a.replaceAll('§', '្ធ');
    a = a.replaceAll('ñ', '្ន');
    a = a.replaceAll(',', '្ប');
    a = a.replaceAll('ö', '្ផ');
    a = a.replaceAll('<', '្ព');
    a = a.replaceAll('Ö', '្ភ');
    a = a.replaceAll('µ', '្ម');
    a = a.replaceAll('ü', '្យ');
    a = a.replaceAll('R', '្រ');
    a = a.replaceAll('®', '្រ');
    a = a.replaceAll('ø', '្ល');
    a = a.replaceAll('V', '្វ');
    a = a.replaceAll('ß', '្ស');
    a = a.replaceAll('H', '្ហ');
    a = a.replaceAll('ð', '្អ');

    // Taller subscripts
    a = a.replaceAll('ú', 'ុ');
    a = a.replaceAll('Ú', 'ូ');
    a = a.replaceAll('Ü', 'ួ');
    a = a.replaceAll('í', 'ិ');
    a = a.replaceAll('Í', 'ី');
    a = a.replaceAll('å', 'ឹ');
    a = a.replaceAll('Å', 'ឺ');

    // Some vowels
    a = a.replaceAll('a', 'ា');
    a = a.replaceAll('i', 'ិ');
    a = a.replaceAll('I', 'ី');
    a = a.replaceAll('w', 'ឹ');
    a = a.replaceAll('W', 'ឺ');
    a = a.replaceAll('u', 'ុ');
    a = a.replaceAll('U', 'ូ');
    a = a.replaceAll('Y', 'ួ');
    a = a.replaceAll('M', 'ំ');
    a = a.replaceAll('¼', 'ះ');

    // Miscellaneous
    a = a.replaceAll('£', 'ៈ');
    a = a.replaceAll('´', '់');
    a = a.replaceAll('@', 'ៗ');
    a = a.replaceAll('‘', '៊');
    a = a.replaceAll('¨', '៉');
    a = a.replaceAll('&', '័');
    a = a.replaceAll('¾', '៏');
    a = a.replaceAll('’', '៌');
    a = a.replaceAll('+', '៎');
    a = a.replaceAll('_', '៍');
    a = a.replaceAll('#', 'ិ៍');
    a = a.replaceAll('>', '៕');
    a = a.replaceAll('²', '«');
    a = a.replaceAll('³', '»');
    a = a.replaceAll('¿', '.');
    a = a.replaceAll('/', ',');
    a = a.replaceAll('-', '_');
    a = a.replaceAll('¥', '-');
    a = a.replaceAll('=', '+');
    a = a.replaceAll('!', '!');
    a = a.replaceAll(r'$', '៛');
    a = a.replaceAll('.', '។');

    a = a.replaceAll('¬', 'ឫ');
    a = a.replaceAll('¦', 'ឬ');
    a = a.replaceAll('\\', 'ឭ');
    a = a.replaceAll('|', 'ឮ');

    // Independent vowels
    a = a.replaceAll('}', 'ឥ');
    a = a.replaceAll('»', 'ឦ');
    a = a.replaceAll('«', 'ឧ');
    a = a.replaceAll(']', 'ឪ');
    a = a.replaceAll('É', 'ឯ');
    a = a.replaceAll('{', 'ឱ');
    a = a.replaceAll('[', 'ឱ្យ');

    a = a.replaceAll('e', 'េ');
    a = a.replaceAll('O', 'ឿ');
    a = a.replaceAll('o', 'ៀ');
    a = a.replaceAll('E', 'ែ');
    a = a.replaceAll('é', 'ៃ');
    a = a.replaceAll('Ó', 'ឿ');
    a = a.replaceAll('ó', 'ៀ');
    a = a.replaceAll('A', 'ៅ');

    // Miscellaneous issues
    a = a.replaceAll(RegExp(r'\u17D2\u179A(.)'), r'$1្រ');
    a = a.replaceAll(RegExp(r'\u17D2\u179A(\u17D2.)'), r'$1្រ');
    a = a.replaceAll(RegExp(r'\u17C1(.[\u17C0\u17BF])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.\u17D2.[\u17C0\u17BF])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.\u17D2.\u17D2.[\u17C0\u17BF])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.[\u17C4\u17C5])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.\u17D2.[\u17C4\u17C5])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.\u17D2.\u17D2.[\u17C4\u17C5])'), r'$1');
    a = a.replaceAll(RegExp(r'\u17C1(.)\u17B6'), r'$1ា');
    a = a.replaceAll(RegExp(r'\u17C1(.)\u17D2.\u17B6'), r'$1ា');
    a = a.replaceAll(RegExp(r'\u17C1(.)\u17D2.\u17D2.\u17B6'), r'$1ា');
    a = a.replaceAll(RegExp(r'(\u179A\u17D2)[\u17BB\u17BC]'), r'$1រ');

    return a;
  }
}
