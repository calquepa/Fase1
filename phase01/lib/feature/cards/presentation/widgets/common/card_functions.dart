import 'package:flutter/material.dart';

import 'package:phase01/core/navigation/routes.dart';
import 'package:phase01/feature/cards/BLOC/card_state.dart';

class CardFunctions {


  double getCurrentScrollPosition(CardState state) {
    double result = 0.0;

    if(state is CardLoaded) {
      result = state.currentPosition;
    }

    return result;
  }

  void backToHomeView(BuildContext context) {
    Navigator.pop(context);

    Navigator.pushNamed(context, Routes.homeRoute);
  }

  String generateId(){
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}