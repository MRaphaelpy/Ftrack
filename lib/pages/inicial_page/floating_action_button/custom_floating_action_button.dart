import 'package:flutter/material.dart';
import 'package:frastreio2/widgets/rounded_textfild.dart';
import 'package:validatorless/validatorless.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function(String codigo, String descricao)? onAddPackage;

  const CustomFloatingActionButton({Key? key, this.onAddPackage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showCustomDialog(context);
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController codigoController = TextEditingController();
    TextEditingController descricaoController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Encomenda'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedTextField(
                  controller: codigoController,
                  labelText: 'Nome',
                  validator: Validatorless.required('Campo obrigatório'),
                ),
                const SizedBox(height: 16.0),
                RoundedTextField(
                  controller: descricaoController,
                  labelText: 'Codigo',
                  validator: Validatorless.required('Campo obrigatório'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  String codigo = codigoController.text;
                  String descricao = descricaoController.text;
                  if (onAddPackage != null) {
                    onAddPackage!(codigo, descricao);
                  }

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
