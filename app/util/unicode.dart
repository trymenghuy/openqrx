import 'dart:convert';

class Unicode {
  static String toLimon(String unicodeText) {
    // Map of Unicode characters to Limon legacy encoding
    final Map<String, int> unicodeToLimon = {
      '\u1780': 0x80, // KA
      '\u1781': 0x81, // KHA
      '\u1782': 0x82, // KO
      // ... Add more mappings here
    };

    List<int> limonBytes = [];

    for (int i = 0; i < unicodeText.length; i++) {
      String char = unicodeText[i];
      if (unicodeToLimon.containsKey(char)) {
        limonBytes.add(unicodeToLimon[char]!);
      } else {
        // For non-Khmer characters, use UTF-8 encoding
        limonBytes.addAll(utf8.encode(char));
      }
    }

    // Convert the bytes to a Latin1 encoded string
    // (which can represent all byte values from 0x00 to 0xFF)
    return latin1.decode(limonBytes);
  }
}
