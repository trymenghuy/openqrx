// class SortHelper<T> {
//   static List<String> sortListIntKey(List<String> keys) {
//     return keys..sort((a, b) => int.parse(b).compareTo(int.parse(a)));
//   }
// }
class SortHelper {
  static List<T> sortListIntKey<T extends Comparable<T>>(List<T> keys) {
    return keys..sort((a, b) => b.compareTo(a));
  }
}
