import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/DAL/card/domain/card_domain_repository.dart';
import 'package:phase01/feature/cards/BLOC/card_event.dart';
import 'package:phase01/feature/cards/BLOC/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  
  // [Properties]
  
  // :Cards:
  static List<CardEntity> readBaseCards = [CardEntity(key: '', value: '', enabled: true)];
  static double currentPosition = 0;
  static DateTime lastRefresh = DateTime.now();
  
  // :Collapse title:
  static Map<String, bool> cardViewStateSummary = {};
  
  // [Constructor]
  CardBloc() : super(getInitialInfo()) {
    // Initial
    on<DoSetCardInitial>(_onSetCardInitial);    
    // [Cards]
    on<DoGetCards>(_onGetCards);
    on<DoAddCard>(_onAddCard);
    on<DoDeleteCard>(_onDeleteCard);
    on<DoUpdateCard>(_onUpdateCard);
    // [Behavior cards]
    on<DoUpdateScrollPosition>(_onUpdateScrollPosition);
  }

  // [Bloc]

  // [Life ciclye]
  static CardState getInitialInfo() {
    return const CardInitial();
  }

  // [Events]
  void _onSetCardInitial(DoSetCardInitial event, Emitter<CardState> emit) async {
    // [Store]
    await _initStores();

    emit(const CardInitial());
  }

  Future<void> _onGetCards(DoGetCards event, Emitter<CardState> emit) async {
    // Show loader
    emit(const CardLoading());

    // Get cards
    readBaseCards = await getCards();
    
    // Set event
    emit(CardLoaded(cards: readBaseCards, currentPosition: currentPosition));
  }

  Future<void> _onAddCard(DoAddCard event, Emitter<CardState> emit) async {
    // Show loader
    emit(const CardLoading());

    // Add card
    bool responseAutoLogin = await CardDomainRepository().addCard(event.cardToAdd);

    // Set event
    if(responseAutoLogin) {
      emit(CardLoaded(cards: readBaseCards, currentPosition: currentPosition));
    }
  }
  
  Future<void> _onDeleteCard(DoDeleteCard event, Emitter<CardState> emit) async {
    // Show loader
    emit(const CardLoading());

    // Add card
    bool responseAutoLogin = await CardDomainRepository().deleteCard(event.cardToDelete);

    // Set event
    if(responseAutoLogin) {
      emit(CardLoaded(cards: readBaseCards, currentPosition: currentPosition));
    }
  }

  Future<void> _onUpdateCard(DoUpdateCard event, Emitter<CardState> emit) async {
    // Show loader
    emit(const CardLoading());

    // Add card
    bool responseAutoLogin = await CardDomainRepository().updateCard(event.cardToUpdate);

    // Set event
    if(responseAutoLogin) {
      emit(CardLoaded(cards: readBaseCards, currentPosition: currentPosition));
    }
  }

  Future<void> _onUpdateScrollPosition(DoUpdateScrollPosition event, Emitter<CardState> emit) async {
    currentPosition = event.scrollPosition;
  }
  
  // [Methods]
  Future<List<CardEntity>> getCards() async {
    readBaseCards = await CardDomainRepository().getAllCards();
    currentPosition = 0;

    return readBaseCards;
  }

  // [Databases]
  Future<void> _initStores() async {

    // [Account Language WindowPreference]
    await CardDomainRepository().initDatabases();
  }
}