import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/core/utils/io/directory_util.dart';
import 'package:phase01/database/base/database_builder_abstract.dart';
import 'package:phase01/database/card/card_database_mapping.dart';
import 'package:phase01/database/card/card_database_model.dart';

class CardDatabase extends DatabaseBuilderAbstract {

  // [Properties]
  String cardDatabaseName = "card-database";
  int cardDatabaseVersion = 1;
  late Database _dbCard;
  late bool isStoreOpened = false;

  // [Constructor]
  CardDatabase._constructor();
  
  // [Singleton]
  static CardDatabase _instance = CardDatabase._constructor();

  factory CardDatabase() {
    return _instance;
  }

  // [Methods] [Override]

  // [Constuctor]
  @override
  Future<void> initDatabase() async {
    final documentsDirectory = await DirectoryUtil.getDirectory(cardDatabaseName);
    final path = join(documentsDirectory.path, cardDatabaseName);
    
    _dbCard = await openDatabase(
      path,
      version: cardDatabaseVersion,
      onCreate: _onCreate,
    );
    
    isStoreOpened = true;
  }
  
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE ${CardDatabaseModel.table} (
            ${CardDatabaseModel.columnId} INTEGER PRIMARY KEY,
            ${CardDatabaseModel.columnKey} TEXT NOT NULL,
            ${CardDatabaseModel.columnValue} TEXT NOT NULL,
            ${CardDatabaseModel.columnEnabled} INTEGER NOT NULL
          )
          ''');
  }

  // [Close]
  @override
  void reset() {
    _instance = CardDatabase._constructor();
  }

  @override
  Future<void> dispose() async {
    isStoreOpened = false;
  }

  @override
  Future<void> removeAllData() async {
    if(isStoreOpened) {
      await _dbCard.delete(
        CardDatabaseModel.table
      );
    }
  }

  @override
  Future<void> deleteDatabase() async {
    if(isStoreOpened){
      await DirectoryUtil.deleteDirectory(cardDatabaseName);
    }
  }

  // [Card]
  Future<int> insertCard(CardEntity card) async {
    if(isStoreOpened){
      Map<String, dynamic> cardRow = CardDatabaseMapping().convertCardToMap(card);
      return await _dbCard.insert(CardDatabaseModel.table, cardRow);
    }
    return 0;
  }

  Future<int> updateCard(CardEntity card) async {
    if(isStoreOpened){
      Map<String, dynamic> mapToUpdate = CardDatabaseMapping().convertCardToMap(card);
      String key = mapToUpdate[CardDatabaseModel.columnId];
      
      return await _dbCard.update(
        CardDatabaseModel.table,
        mapToUpdate,
        where: '${CardDatabaseModel.columnId} = ?',
        whereArgs: [key],
      );
    }

    return 0;
  }

  // [Cards]
  Future<int> cardsRowCount() async {
    if(isStoreOpened){
      final results = await _dbCard.rawQuery('SELECT COUNT(*) FROM ${CardDatabaseModel.table}');
      return Sqflite.firstIntValue(results) ?? 0;
    }
    return 0;
  }

  Future<List<CardEntity>> selectCards() async {
    if(isStoreOpened) {
      List<CardEntity> cards = [];

      List<Map<String, dynamic>> cardsInDB = await _dbCard.query(CardDatabaseModel.table);
      cards = CardDatabaseMapping().convertMapListToCards(cardsInDB);

      return cards;
    }
    else {
      return [];
    }
  }

  Future<int> deleteCard(CardEntity card) async {
    if(isStoreOpened){
      Map<String, dynamic> mapToUpdate = CardDatabaseMapping().convertCardToMap(card);
      String key = mapToUpdate[CardDatabaseModel.columnId];
      
      return await _dbCard.delete(CardDatabaseModel.table, where: '${CardDatabaseModel.columnId} = ?',
        whereArgs: [key],);
    }
    return 0;
  }
}