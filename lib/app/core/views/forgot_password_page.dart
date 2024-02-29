// ignore_for_file: use_build_context_synchronously

import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'widgets/custom_dialog_widget.dart';
import 'widgets/custom_textform_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _userStore = Modular.get<UsersStore>();
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final isRequiredField = 'Este campo é obrigatório!';

  @override
  void dispose() {
    _email.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 10;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Recuperar Senha',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomTextFormWidget(
                    maxlines: 1,
                    controller: _email,
                    label: const Text('Email'),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return isRequiredField;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: spacing),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
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
                                  Text('Enviando...'),
                                  SizedBox(height: 10),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          }

                          await _userStore
                              .sendForgotPasswordFromEmail(_email.text.trim())
                              .whenComplete(() => Modular.to.pop());
                          Modular.to.pushNamed(
                              '/verifyOTP?email=${_email.text.trim()}');
                        } on AuthException catch (e) {
                          Modular.to.pop();
                          if (mounted) {
                            SnackBarWidget.errorSnackBar(context, e.message);
                          }
                        }
                      }
                    },
                    child: const Text('Confirmar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
