import 'package:control_data/app/core/views/widgets/custom_dialog_widget.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../modules/users/views/users_store.dart';
import 'widgets/snackbar_widget.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key, required this.email});
  final String email;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _userStore = Modular.get<UsersStore>();

  final _formKey = GlobalKey<FormState>();

  final _tokenCrontroller = TextEditingController();

  final isRequiredField = 'Este campo é obrigatório!';

  @override
  void dispose() {
    _tokenCrontroller.dispose();

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
                    'Verificação Token',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomTextFormWidget(
                    maxlines: 1,
                    controller: _tokenCrontroller,
                    label: const Text('Token'),
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
                                  Text('Verificando...'),
                                  SizedBox(height: 10),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          }

                          await _userStore
                              .verifyOTP(_tokenCrontroller.text.trim(),
                                  widget.email.trim())
                              .whenComplete(() => Modular.to.pop());
                          Modular.to.pushNamed('/resetPassword');
                        } on AuthException catch (e) {
                          Modular.to.pop();
                          if (mounted) {
                            SnackBarWidget.errorSnackBar(context, e.message);
                          }
                        }
                      }
                    },
                    child: const Text('Verificar'),
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
