// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/views/widgets/custom_dialog_widget.dart';
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

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final isRequiredField = 'Este campo é obrigatório!';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _userStore.obscurePassword = true;
    _userStore.obscureConfirmPassword = true;
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
            child: Observer(builder: (context) {
              return Form(
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
                      maxlines: 1,
                      controller: _passwordController,
                      label: const Text('Senha'),
                      obscureText: _userStore.obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _userStore.changeObscurePassword();
                        },
                        icon: _userStore.obscurePassword
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove),
                      ),
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
                      maxlines: 1,
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.emailAddress,
                      label: const Text('Confirmar Senha'),
                      obscureText: _userStore.obscureConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _userStore.changeObscureConfirmPassword();
                        },
                        icon: _userStore.obscureConfirmPassword
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove),
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return isRequiredField;
                        }

                        if (_passwordController.text.trim() !=
                            _confirmPasswordController.text.trim()) {
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
                            await _userStore
                                .updatePassword(_passwordController.text.trim())
                                .whenComplete(() => Modular.to.pop());
                            if (mounted) {
                              SnackBarWidget.successSnackBar(
                                  context, 'Senha alterada com sucesso!');
                            }

                            Modular.to.pop();
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
              );
            }),
          ),
        ),
      ),
    );
  }
}
