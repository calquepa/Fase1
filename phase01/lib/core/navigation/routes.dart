import 'package:flutter/material.dart';

import 'package:phase01/feature/cards/presentation/pages/home_cards_page.dart';
import 'package:phase01/feature/cards/presentation/widgets/card_details.dart';
import 'package:phase01/feature/cards/presentation/widgets/card_form.dart';

class Routes {

  // App
  static const homeRoute = 'HomeCardPage';

  // Card Details
  static const detailCardRoute = 'CardDetails';

  // New or Update Card
  static const formCardRoute = 'CardForm';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> routes = {};

    routes.addAll({
      // Home
      homeRoute : ( BuildContext context ) => const HomeCardsPage(),
      // Details Card
      detailCardRoute : ( BuildContext context ) => const CardDetails(),
      // Form Card
      formCardRoute : ( BuildContext context ) => const CardForm(),
    });

    return routes;
  }

  static Route<dynamic> onGenerateRoute( RouteSettings settings) {        
    return MaterialPageRoute(
        builder: (context) => const HomeCardsPage(),
        
    );
  }

}