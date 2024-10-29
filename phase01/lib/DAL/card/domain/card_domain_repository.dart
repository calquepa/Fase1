import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/DAL/card/data/card_local_datasource.dart';
import 'package:phase01/DAL/card/database/card_local_database.dart';

class CardDomainRepository {

  // [Card]
  Future<List<CardEntity>> getAllCards() async {
    List<CardEntity> cards = [];

    // Read in database
    cards = await CardLocalDatasource().getAllCards();
    
    return cards;
  }
  
  Future<bool> addCard(CardEntity card) {
    return CardLocalDatasource().addCard(card);
  }

  Future<bool> updateCard(CardEntity card) {
    return CardLocalDatasource().updateCard(card);
  }

  Future<bool> deleteCard(CardEntity card) {
    return CardLocalDatasource().deleteCard(card);
  }
  
  // [Database]
  Future<void> initDatabases() async {
    await CardLocalDatabase().initDatabases();
  }
}