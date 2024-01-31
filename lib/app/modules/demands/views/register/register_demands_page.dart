import 'package:control_data/app/core/model/user_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:uuid/uuid.dart';

class RegisterDemandsPage extends StatefulWidget {
  const RegisterDemandsPage({super.key, required this.user});
  final UserModel user;

  @override
  State<RegisterDemandsPage> createState() => _RegisterDemandsPageState();
}

class _RegisterDemandsPageState extends State<RegisterDemandsPage> {
  final _store = Modular.get<DemandsStore>();
  final _keyForm = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Demanda'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFormWidget(
                  autofocus: true,
                  controller: _titleController,
                  label: const Text('Titulo'),
                ),
                const SizedBox(height: 10),
                CustomTextFormWidget(
                  maxlines: 6,
                  controller: _descriptionController,
                  label: const Text('Descrição da Demanda'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_keyForm.currentState!.validate()) {
                      String solicitationDate =
                          DateTime.now().toString().split(' ')[0];
                      Map<String, dynamic> json = {
                        "id": uuid.v4(),
                        "title": _titleController.text.trim(),
                        "description": _descriptionController.text.trim(),
                        "solicitation_date": solicitationDate,
                        "done_date": null,
                        "done": false,
                        "user_id": user.id,
                      };

                      await _store.createDemands(json);
                      Modular.to.pop();
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
