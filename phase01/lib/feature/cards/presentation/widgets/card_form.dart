import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:phase01/core/config/environment.dart';
import 'package:phase01/core/entities/card_entity.dart';
import 'package:phase01/feature/cards/BLOC/card_bloc.dart';
import 'package:phase01/feature/cards/BLOC/card_event.dart';
import 'package:phase01/feature/cards/presentation/widgets/common/card_functions.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  State<CardForm> createState() => _CardForm();
}

class _CardForm extends State<CardForm> {

  String _key = ''; // Variable to store the entered key 
  String _value = ''; // Variable to store the entered value 
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CardEntity? parameterCard = ModalRoute.of(context)!.settings.arguments != null ? 
      ModalRoute.of(context)!.settings.arguments as CardEntity : null;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(Environment.formAddCardTitle),
        leading: IconButton(onPressed: () => CardFunctions().backToHomeView(context), icon: const Icon(Icons.arrow_back_ios))
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0,0.0,16.0,0.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: parameterCard != null ? parameterCard.key : '',
                  enabled: parameterCard != null ? false : true,
                  decoration: const InputDecoration(
                    labelText: 'Llave',
                    hintText: 'Nombre describe campo',
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    constraints: BoxConstraints(maxHeight: 80.0, maxWidth: double.infinity),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) { 
                    _key = value!; // Save the entered name 
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: parameterCard != null ? parameterCard.value : '',
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    hintText: 'Resultado o descripcion del campo',
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(maxHeight: 80.0, maxWidth: double.infinity),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) { 
                    _value = value!; // Save the entered name 
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      CardEntity card = CardEntity(
                        key: _key,
                        value: _value,
                        enabled: true,
                      );
                      if (parameterCard == null) {
                        context.read<CardBloc>().add(DoAddCard(cardToAdd: card));
                      }else {
                        context.read<CardBloc>().add(DoUpdateCard(cardToUpdate: card));
                      }
                      CardFunctions().backToHomeView(context);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}