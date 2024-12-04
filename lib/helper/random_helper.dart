import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';

class RandomHelper {
  static String stringSha1(String text) {
    final bytes = utf8.encode(text);
    return sha1.convert(bytes).toString();
  }

  static String stringSha256(String text) {
    final bytes = utf8.encode(text);
    return sha256.convert(bytes).toString();
  }

  static String stringMd5(String input) {
    List<int> bytes = utf8.encode(input);
    Digest md5Result = md5.convert(bytes);
    return md5Result.toString();
  }

  static const int _epoch =
      1672531200000; // Unix timestamp for 2021-01-01 00:00:00

  static int get snowflakeId {
    int sequence = 0;
    int lastTimestamp = -1;
    int timestamp = DateTime.now().millisecondsSinceEpoch - _epoch;

    if (timestamp == lastTimestamp) {
      sequence = (sequence + 1) % 4096; // 12-bit sequence number
      if (sequence == 0) {
        // If sequence overflows, wait for the next millisecond
        while (timestamp <= lastTimestamp) {
          sleep(const Duration(milliseconds: 1));
          timestamp = DateTime.now().millisecondsSinceEpoch - _epoch;
        }
      }
    } else {
      sequence = 0;
    }

    lastTimestamp = timestamp;

    // Assuming your application has a unique identifier (e.g., worker ID)
    int workerId = 1; // Replace with your worker ID
    int dataCenterId = 1; // Replace with your data center ID

    // Constructing the Snowflake ID with 41 bits timestamp, 5 bits data center ID, 5 bits worker ID, and 12 bits sequence
    int snowflakeId = ((timestamp & 0x1FFFFFFFFFF) << 22) |
        ((dataCenterId & 0x1F) << 17) |
        ((workerId & 0x1F) << 12) |
        (sequence & 0xFFF);

    return snowflakeId;
  }
}
