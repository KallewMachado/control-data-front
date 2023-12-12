import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:flutter/material.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
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
  //  AuthModel auth = AuthModel(
  //                   id: '',
  //                   email: 'kallewcarlos@gmail.com',
  //                   password: '654321',
  //                 );
  //                 DateTime date = DateTime(1997, 9, 18);
  //                 // DateTime dateCreateAt = DateTime.now();

  //                 AuthModel result = await _store.createUser(auth);

  //                 Map<String, dynamic> json = {
  //                   "id": result.id,
  //                   "name": 'Kallew',
  //                   "email": result.email,
  //                   "date_birth": date.toString().split(' ')[0],
  //                   "fone": '62 99862-9233',
  //                   "street": 'Rua 7 de Setembro',
  //                   "num": '31',
  //                   "district": 'Vila Santa Rita',
  //                   "complement": '',
  //                   "user_created": result.id,
  //                   "demands": [],
  //                 };

  //                 await _store.newUser(json);

  @override
  Widget build(BuildContext context) {
    double spacing = 10;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextFormWidget(
                    controller: _nameController, label: const Text('Nome')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _emailController, label: const Text('E-mail')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _passwordController,
                    label: const Text('Senha')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _confirmPasswordController,
                    label: const Text('Confirmar Senha')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _foneController, label: const Text('Celular')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _dateBirthController,
                    label: const Text('Data de nascimento')),
                SizedBox(height: spacing),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: CustomTextFormWidget(
                          controller: _endressController,
                          label: const Text('Endereço')),
                    ),
                    Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CustomTextFormWidget(
                          controller: _numController,
                          label: const Text('Numero')),
                    ),
                  ],
                ),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _districtController,
                    label: const Text('Bairro')),
                SizedBox(height: spacing),
                CustomTextFormWidget(
                    controller: _complementController,
                    label: const Text('Complemento')),
                SizedBox(height: spacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
