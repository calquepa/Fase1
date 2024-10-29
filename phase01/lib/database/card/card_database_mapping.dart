import 'package:phase01/core/entities/card_entity.dart';

class CardDatabaseMapping {
  
  Map<String, dynamic> convertCardToMap(CardEntity card) {
    Map<String, dynamic> cardRow = <String, dynamic> 
    {
      "id": card.id,
      "key": card.key,
      "value": card.value,
      "enabled": card.enabled == true ? 1 : 0,
    };

    return cardRow;
  }

  CardEntity convertMapToCardEntity(Map<String, dynamic> card) {
    CardEntity cardObject = CardEntity(
      id: card["id"].toString(),
      key: card["key"],
      value: card["value"],
      enabled: card["enabled"] == 0 ? false : true,
    );

    return cardObject;
  }

  List<CardEntity> convertMapListToCards(List<Map<String, dynamic>> cardsInDB) {
    List<CardEntity> cards = [];

    for (var cardInDB in cardsInDB) {
      if(cardInDB.isNotEmpty) {
        cards.add(convertMapToCardEntity(cardInDB));
      }
    }

    return cards;
  }
}