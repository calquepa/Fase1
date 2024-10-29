import 'package:phase01/core/entities/card_entity.dart';

class CardDatabaseMapping {
  
  Map<String, dynamic> convertLanguageToMap(CardEntity language) {
    Map<String, dynamic> languageRow = <String, dynamic> 
    {
      "key": language.key,
      "value": language.value,
      "enabled": language.enabled == true ? 1 : 0,
    };

    return languageRow;
  }

  CardEntity convertMapToCardEntity(Map<String, dynamic> language) {
    CardEntity languageObject = CardEntity(
      enabled: language["enabled"] == 0 ? false : true,
      key: language["key"],
      value: language["value"],
    );

    return languageObject;
  }

  List<CardEntity> convertMapListToLanguages(List<Map<String, dynamic>> languagesInDB) {
    List<CardEntity> languages = [];

    for (var languageInDB in languagesInDB) {
      if(languageInDB.isNotEmpty) {
        languages.add(convertMapToCardEntity(languageInDB));
      }
    }

    return languages;
  }
}