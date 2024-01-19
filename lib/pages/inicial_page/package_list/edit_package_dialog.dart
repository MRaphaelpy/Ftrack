import 'package:flutter/material.dart';
import 'package:frastreio2/widgets/rounded_textfild.dart';
import 'package:validatorless/validatorless.dart';

class EditPackageDialog extends StatelessWidget {
  final String oldNome;
  final String oldCodigo;
  final Function(String, String) onEdit;

  const EditPackageDialog({
    super.key,
    required this.oldNome,
    required this.oldCodigo,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nomeController =
        TextEditingController(text: oldNome);
    final TextEditingController codigoController =
        TextEditingController(text: oldCodigo);

    return AlertDialog(
      title: const Text('Editar Pacote', style: TextStyle(fontSize: 18.0)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RoundedTextField(
              controller: nomeController,
              labelText: "Nome",
              validator: Validatorless.required('Campo obrigatório'),
            ),
            const SizedBox(height: 8.0),
            RoundedTextField(
              controller: codigoController,
              labelText: 'Código',
              validator: Validatorless.required('Campo obrigatório'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onEdit(nomeController.text, codigoController.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
