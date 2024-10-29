import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phase01/core/config/environment.dart';
import 'package:phase01/core/navigation/routes.dart';

import 'package:phase01/feature/cards/BLOC/card_bloc.dart';
import 'package:phase01/feature/cards/BLOC/card_event.dart';
import 'package:phase01/feature/cards/BLOC/card_state.dart';
import 'package:phase01/feature/cards/presentation/widgets/card_data.dart';

class HomeCardsPage extends StatefulWidget {
  const HomeCardsPage({ super.key });

  @override
  State<StatefulWidget> createState() => _HomeCardsPageState();
}

class _HomeCardsPageState extends State<HomeCardsPage> {
  
  @override
  void initState() {
    
    context.read<CardBloc>().add(DoSetCardInitial(context: context));

    super.initState();
    Future.delayed(const Duration(seconds: 2), () {

    // Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        context.read<CardBloc>().add(const DoGetCards());
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(Environment.appTitle,style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
            actions: [
              IconButton(onPressed: () => Navigator.popAndPushNamed(context, Routes.formCardRoute), icon: const Icon(Icons.add_card)),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: 
                  state is CardLoaded ?
                  const CardData() :
                  const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      }
    );
  }
}