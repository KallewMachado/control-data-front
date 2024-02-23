// ignore_for_file: use_build_context_synchronously

import 'package:control_data/app/core/model/user_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/views/widgets/custom_dialog_widget.dart';

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
                  validator: (title) {
                    if (title == null || title.isEmpty) {
                      return "campo vazio";
                    }
                    return null;
                  },
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
                      try {
                        if (mounted) {
                          CustomDialogWidet.show(
                            context,
                            barrierDismissible: false,
                            actions: [],
                            content: (context) => const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Salvando...'),
                                SizedBox(height: 10),
                                CircularProgressIndicator(),
                              ],
                            ),
                          );
                        }
                        var userCreated = _store.hive.userBox.values.first.id;

                        String solicitationDate = DateTime.now().toString();
                        Map<String, dynamic> json = {
                          "id": uuid.v4(),
                          "title": _titleController.text.trim(),
                          "description": _descriptionController.text.trim(),
                          "solicitation_date": solicitationDate,
                          "done_date": null,
                          "done": false,
                          "user_id": user.id,
                          "user_created": userCreated,
                        };

                        await _store.createDemands(json);
                        if (mounted) {
                          SnackBarWidget.successSnackBar(
                              context, 'Demanda criada com Sucesso!');
                        }

                        await _store
                            .getAllDemandsByUser(user.id)
                            .whenComplete(() => Modular.to.pop());

                        Modular.to.pop();
                      } on PostgrestException catch (e) {
                        if (mounted) {
                          SnackBarWidget.errorSnackBar(context, e.message);
                        }
                      }
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
