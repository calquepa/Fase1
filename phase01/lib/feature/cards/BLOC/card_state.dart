import 'package:phase01/core/entities/card_entity.dart';

abstract class CardState {
  const CardState();
}

// [Life cycle]
class CardInitial extends CardState {
  const CardInitial() : super();
}

// [Cards]
class CardLoading extends CardState {
  const CardLoading() : super();
}

class CardLoaded extends CardState {
  
  final List<CardEntity> cards;
  final double currentPosition;
  
  const CardLoaded({required this.cards, required this.currentPosition}) : super();
}