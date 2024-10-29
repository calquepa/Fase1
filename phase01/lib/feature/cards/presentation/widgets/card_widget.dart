import 'package:flutter/material.dart';

import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/core/navigation/routes.dart';

class CardWidget extends StatefulWidget {
  final CardEntity cardEntity;

  const CardWidget({super.key, required this.cardEntity});

  @override
  State<CardWidget> createState() => _CardWidget();
}

class _CardWidget extends State<CardWidget> {
  late CardEntity cardEntity;

  @override
  Widget build(BuildContext context) {
    // Set current card information
    initLocalState();

    return Center(
      child:
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.detailCardRoute, arguments: cardEntity);
            },
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.album),
                    title: Text(cardEntity.key),
                    subtitle: Text(cardEntity.value),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  void initLocalState() {
    cardEntity = widget.cardEntity;
  }
}