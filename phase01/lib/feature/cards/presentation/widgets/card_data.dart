import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/feature/cards/BLOC/card_bloc.dart';
import 'package:phase01/feature/cards/BLOC/card_event.dart';
import 'package:phase01/feature/cards/BLOC/card_state.dart';
import 'package:phase01/feature/cards/presentation/widgets/card_widget.dart';
import 'package:phase01/feature/cards/presentation/widgets/common/card_functions.dart';

class CardData extends StatefulWidget {
  const CardData({super.key});

  @override
  State<CardData> createState() => _CardData();
}

class _CardData extends State<CardData> {
  ScrollController _cardsScrollController = ScrollController();
  List<Widget> dataWidgets = [];

  @override
  void initState() {
    super.initState();
    _cardsScrollController = ScrollController(initialScrollOffset: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardBloc, CardState>(
      builder: (context, state) {
        _cardsScrollController = ScrollController(initialScrollOffset: CardFunctions().getCurrentScrollPosition(state));

        if(state is CardLoaded) {
          // Clean cards
          dataWidgets = [];
          // Fill cards by state
          fillCards(state);
        }

        return Scrollbar(
          controller: _cardsScrollController,
          thickness: 4.0,
          child: Stack(
            children: [
              Column(
                children: [
                  Text((state is CardLoaded ? state.cards.length.toString() : '0')),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollUpdateNotification) {
                            context.read<CardBloc>().add(DoUpdateScrollPosition(scrollPosition: notification.metrics.pixels));
                          }
                          return false;
                        },
                        child:  ListView.builder(
                          // This is for last card (bottom => Navigation bar)
                          padding: const EdgeInsets.only(bottom: 5.0),
                          // This is for can refresh cards if the cards size is less to 3
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _cardsScrollController,
                          itemCount: dataWidgets.length,
                          itemBuilder: (BuildContext context, int index) {
                            return dataWidgets[index];
                          }
                        ),
                      ),
                    ),
                  ),
                ]
              ),
          ]),
        );
      }
    );
  }

  void fillCards(CardState state) {
    if(state is CardLoaded) {
      if(state.cards.isNotEmpty) {
        // Add activities by state
        for(CardEntity card in state.cards) {
          dataWidgets.add(CardWidget(cardEntity: card));
        }
      }
    }
  }
}