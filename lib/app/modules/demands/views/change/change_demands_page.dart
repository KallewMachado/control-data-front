import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ChangeDemandsPage extends StatefulWidget {
  const ChangeDemandsPage({super.key, required this.demand});
  final DemandsModel demand;

  @override
  State<ChangeDemandsPage> createState() => _ChangeDemandsPageState();
}

class _ChangeDemandsPageState extends State<ChangeDemandsPage> {
  final _store = Modular.get<DemandsStore>();
  final _keyForm = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.demand.title;
    _descriptionController.text = widget.demand.description ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final demand = widget.demand;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Demanda'),
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
                        Map<String, dynamic> json = {
                          "title": _titleController.text.trim(),
                          "description": _descriptionController.text.trim(),
                        };

                        await _store.updateDemands(json, demand.id);
                        if (mounted) {
                          SnackBarWidget.successSnackBar(
                              context, 'Demanda Alterada com Sucesso!');
                        }

                        await _store.getAllDemandsByUser(demand.userId);

                        Modular.to.pop();
                      } on PostgrestException catch (e) {
                        SnackBarWidget.errorSnackBar(context, e.message);
                      }
                    }
                  },
                  child: const Text('Salvar'),
                ),
                OutlinedButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
