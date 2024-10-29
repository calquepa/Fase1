class CardEntity {

  // [Constructor]
  CardEntity({
    required this.id,
    required this.key,
    required this.value,
    required this.enabled
  });
  
  // [Properties]
  String id;
  String key;
  String value;
  bool enabled;

  // For send data to Native
  Object toJSON() {
    return {
      "id" : id,
      "key" : key,
      "value" : value,
      "enabled": enabled
    };
  }
}