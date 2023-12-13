import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../model/auth_model.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _authStore = Modular.get<AuthStore>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _endressController = TextEditingController();
  final _numController = TextEditingController();
  final _foneController = TextEditingController();
  final _districtController = TextEditingController();
  final _complementController = TextEditingController();
  final _dateBirthController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _endressController.dispose();
    _numController.dispose();
    _foneController.dispose();
    _districtController.dispose();
    _complementController.dispose();
    _dateBirthController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double spacing = 10;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  CustomTextFormWidget(
                    controller: _nameController,
                    label: const Text('Nome'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _emailController,
                    label: const Text('E-mail'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _passwordController,
                    label: const Text('Senha'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _confirmPasswordController,
                    label: const Text('Confirmar Senha'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _foneController,
                    label: const Text('Celular'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _dateBirthController,
                    label: const Text('Data de nascimento'),
                  ),
                  SizedBox(height: spacing),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: CustomTextFormWidget(
                          controller: _endressController,
                          label: const Text('Endereço'),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: CustomTextFormWidget(
                          controller: _numController,
                          label: const Text('Numero'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _districtController,
                    label: const Text('Bairro'),
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _complementController,
                    label: const Text('Complemento'),
                  ),
                  const SizedBox(height: 40),
                  OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        AuthModel auth = AuthModel(
                          id: '',
                          email: 'kallewcarlos@gmail.com',
                          password: '654321',
                        );

                        DateTime date =
                            DateTime.parse(_dateBirthController.text.trim());
                        String dateBirth = date.toString().split(' ')[0];

                        AuthModel result = await _authStore.createUser(auth);

                        Map<String, dynamic> json = {
                          "id": result.id,
                          "name": _nameController.text.trim(),
                          "email": result.email,
                          "date_birth": dateBirth,
                          "fone": _foneController.text.trim(),
                          "street": _endressController.text.trim(),
                          "num": _numController.text.trim(),
                          "district": _districtController.text.trim(),
                          "complement": _complementController.text.trim(),
                          "user_created": result.id,
                        };

                        await _authStore.newUser(json);
                      }
                    },
                    child: const Text('Registrar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Modular.to.pop();
                    },
                    child: const Text('Cancelar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
