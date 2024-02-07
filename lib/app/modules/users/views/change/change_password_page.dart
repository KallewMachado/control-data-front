import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/views/widgets/custom_textform_widget.dart';
import '../../../../core/views/widgets/snackbar_widget.dart';
import '../users_store.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _userStore = Modular.get<UsersStore>();
  final _formKey = GlobalKey<FormState>();

  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final isRequiredField = 'Este campo é obrigatório!';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
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
                    'Alterar Senha',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomTextFormWidget(
                    controller: _password,
                    label: const Text('Senha'),
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return isRequiredField;
                      }
                      if (password.length < 6) {
                        return 'Senha precisa ter mais q 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _confirmPassword,
                    keyboardType: TextInputType.emailAddress,
                    label: const Text('Confirmar Senha'),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return isRequiredField;
                      }

                      if (_password.text != _confirmPassword.text) {
                        return 'Senha diferente!';
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
                          await _userStore.updatePassword(_password.text);
                          if (mounted) {
                            SnackBarWidget.successSnackBar(
                                context, 'Senha alterada com sucesso!');
                          }

                          Modular.to.pop();
                        } on AuthException catch (e) {
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
