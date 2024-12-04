abstract class GenericFormAbstract {
  void onChanged(String key, dynamic value);
  void removeNestedQtyInput(String key, String id);
  void onSumQtyChanged(String key, String id, int value);
  void onQtyChanged(String key, String id, int value);
  void onNestInputChanged(String key, String id, dynamic value,
      {bool notify = false});
}
