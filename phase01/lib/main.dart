import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phase01/core/config/environment.dart';
import 'package:phase01/core/navigation/routes.dart';
import 'package:phase01/feature/cards/BLOC/card_bloc.dart';
import 'package:phase01/feature/cards/presentation/pages/home_cards_page.dart';

void main() {
  runApp(BlocProvider(create: (context) => CardBloc(), 
    child:  const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: Environment.appTitle,
      home: const HomeCardsPage(),
      routes: Routes.getAppRoutes(),
    );
  }
}
