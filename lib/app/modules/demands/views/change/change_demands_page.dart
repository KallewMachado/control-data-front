// ignore_for_file: use_build_context_synchronously

import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/views/widgets/custom_dialog_widget.dart';

class ChangeDemandsPage extends StatefulWidget {
  const ChangeDemandsPage({super.key, required this.demand});
  final DemandsModel demand;

  @override
  State<ChangeDemandsPage> createState() => _ChangeDemandsPageState();
}

class _ChangeDemandsPageState extends State<ChangeDemandsPage> {
  late final DemandsStore _store;
  late final GlobalKey<FormState> _keyForm;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  var uuid = const Uuid();

  @override
  void initState() {
    super.initState();

    _store = Modular.get<DemandsStore>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _keyForm = GlobalKey<FormState>();

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
                  onPressed: _validation,
                  child: const Text('Salvar'),
                ),
                TextButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validation() async {
    if (_keyForm.currentState!.validate()) {
      try {
        final demand = widget.demand;
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
        Map<String, dynamic> json = {
          "title": _titleController.text.trim(),
          "description": _descriptionController.text.trim(),
        };

        await _store.updateDemands(json, demand.id);
        if (mounted) {
          SnackBarWidget.successSnackBar(
              context, 'Demanda Alterada com Sucesso!');
        }

        await _store
            .getAllDemandsByUser(demand.userId)
            .whenComplete(() => Modular.to.pop());

        Modular.to.pop();
      } on PostgrestException catch (e) {
        Modular.to.pop();
        if (mounted) {
          SnackBarWidget.errorSnackBar(context, e.message);
        }
      }
    }
  }
}
