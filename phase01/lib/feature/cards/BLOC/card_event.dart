import 'package:flutter/material.dart';
import 'package:phase01/core/entities/card_entity.dart';

abstract class CardEvent {
  // [Constructor]
  const CardEvent();
}

class DoSetCardInitial extends CardEvent {
  final BuildContext context;

  const DoSetCardInitial({required this.context});
}

// Cards
class DoGetCards extends CardEvent {
  const DoGetCards();
}

class DoAddCard extends CardEvent {
  final CardEntity cardToAdd;

  const DoAddCard({required this.cardToAdd});
}

class DoDeleteCard extends CardEvent {
  final CardEntity cardToDelete;

  const DoDeleteCard({required this.cardToDelete});
}

class DoUpdateCard extends CardEvent {
  final CardEntity cardToUpdate;

  const DoUpdateCard({required this.cardToUpdate});
}

// Scroll
class DoUpdateScrollPosition extends CardEvent {
  final double scrollPosition;

  const DoUpdateScrollPosition({required this.scrollPosition});
}