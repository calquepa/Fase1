import 'package:phase01/database/base/database_director.dart';
import 'package:phase01/database/card/card_database.dart';

class CardLocalDatabase {

  // [Properties]
  late CardDatabase cardDatabase = CardDatabase();

  // [Methods]
  Future<void> initDatabases() async {    
    // [Card]
    await initCardDatabase();

    if(cardDatabase.isStoreOpened == false) {      
      Future.delayed(const Duration(seconds: 3), () async {
        await initCardDatabase();
      });
    }
  }

  Future<void> initCardDatabase() async {
    // Card
    DatabaseDirector director = DatabaseDirector();
    await director.constructStore(cardDatabase);
  }

  // [Dismiss]
  void dismiss() {
    cardDatabase.dispose();
  }
}