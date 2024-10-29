import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/core/navigation/routes.dart';
import 'package:phase01/feature/cards/BLOC/card_bloc.dart';
import 'package:phase01/feature/cards/BLOC/card_event.dart';
import 'package:phase01/feature/cards/presentation/widgets/common/card_functions.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetails();
}

class _CardDetails extends State<CardDetails> {
  
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    CardEntity parameterCard = ModalRoute.of(context)!.settings.arguments as CardEntity;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => CardFunctions().backToHomeView(context), icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Card Title'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getAllInformation(parameterCard),
            const SizedBox(height: 5.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, Routes.formCardRoute, arguments: parameterCard);
                    },
                    label: const Text('Editar'),
                  ),
                ),
                const SizedBox(width: 15.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    onPressed: () {
                      context.read<CardBloc>().add(DoDeleteCard(cardToDelete: parameterCard));
                      CardFunctions().backToHomeView(context);
                    },
                    label: const Text('Eliminar', style: TextStyle(color: Colors.red),),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget _getAllInformation(CardEntity parameterCard) {

    return Expanded(
      child: Scrollbar(
        controller: scrollController,
        thickness: 4.0,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 12.0),                           
            _labelInformation(parameterCard.key, const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14.0),
            _labelInformation(parameterCard.value, const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _labelInformation(String information, TextStyle styleText) {
    return Text(information,
        style: styleText,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        maxLines: 10,
      );
  }
}