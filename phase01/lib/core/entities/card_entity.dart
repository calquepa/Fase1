class CardEntity {

  // [Constructor]
  CardEntity({
    required this.key,
    required this.value,
    required this.enabled
  });
  
  // [Properties]
  String key;
  String value;
  bool enabled;

  // For send data to Native
  Object toJSON() {
    return {
      "key" : key,
      "value" : value,
      "enabled": enabled
    };
  }
}