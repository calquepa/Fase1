import 'package:phase01/DAL/card/database/card_local_database.dart';
import 'package:phase01/core/entities/card_entity.dart';

class CardLocalDatasource implements Exception{
  // [Singleton]
  static final CardLocalDatasource _instance = CardLocalDatasource._constructor();

  factory CardLocalDatasource() {
    return _instance;
  }

  // [Constructor]
  CardLocalDatasource._constructor();
  

  // [Card]
  Future<List<CardEntity>> getAllCards() async {
    List<CardEntity> cardsList = await CardLocalDatabase().cardDatabase.selectCards();
    return cardsList;
  }

  Future<bool> addCard(CardEntity card) async {
    return CardLocalDatabase().cardDatabase.insertCard(card) == 0 ? false : true;
  }

  Future<bool> updateCard(CardEntity card) async {
    return CardLocalDatabase().cardDatabase.updateCard(card) == 0 ? false : true;
  }

  Future<bool> deleteCard(CardEntity card) async {
    return CardLocalDatabase().cardDatabase.deleteCard(card) == 0 ? false : true;
  }
}