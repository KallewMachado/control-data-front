import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _userStore = Modular.get<UsersStore>();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _endressController = TextEditingController();
  final _numController = TextEditingController();
  final _foneController = TextEditingController();
  final _districtController = TextEditingController();
  final _complementController = TextEditingController();
  final _dateBirthController = TextEditingController();

  var uuid = const Uuid();

  final isRequiredField = 'Este campo é obrigatório!';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
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
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Registrar Usuario',
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 50),
                  CustomTextFormWidget(
                    controller: _nameController,
                    label: const Text('Nome'),
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _cpfController,
                    label: const Text('CPF'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    validator: (cpf) {
                      if (cpf == null || cpf.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: const Text('E-mail'),
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _foneController,
                    label: const Text('Celular'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (fone) {
                      if (fone == null || fone.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    isDate: true,
                    controller: _dateBirthController,
                    readOnly: true,
                    label: const Text('Data de nascimento'),
                    validator: (dateBirth) {
                      if (dateBirth == null || dateBirth.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: spacing),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: CustomTextFormWidget(
                          controller: _endressController,
                          label: const Text('Endereço'),
                          validator: (endress) {
                            if (endress == null || endress.isEmpty) {
                              return isRequiredField;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: CustomTextFormWidget(
                          controller: _numController,
                          label: const Text('Numero'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return isRequiredField;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  CustomTextFormWidget(
                    controller: _districtController,
                    label: const Text('Bairro'),
                    validator: (district) {
                      if (district == null || district.isEmpty) {
                        return isRequiredField;
                      } else {
                        return null;
                      }
                    },
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
                        try {
                          DateTime date = DateTime.parse(_dateBirthController
                              .text
                              .replaceAll('/', '-')
                              .trim());
                          String dateBirth = date.toString().split(' ')[0];

                          Map<String, dynamic> json = {
                            "id": uuid.v4(),
                            "name": _nameController.text.trim(),
                            "cpf": _cpfController.text.trim(),
                            "email": _emailController.text.trim(),
                            "date_birth": dateBirth,
                            "fone": _foneController.text.trim(),
                            "street": _endressController.text.trim(),
                            "num": _numController.text.trim(),
                            "district": _districtController.text.trim(),
                            "complement": _complementController.text.trim(),
                            "user_created": _userStore.user.id,
                          };

                          await _userStore.newUser(json);
                          await _userStore.getAllUsers();
                          if (mounted) {
                            SnackBarWidget.successSnackBar(
                                context, 'Usuario registrado com sucesso!');
                          }

                          Modular.to.pop();
                        } on AuthException catch (e) {
                          if (mounted) {
                            SnackBarWidget.errorSnackBar(context, e.message);
                          }
                        } on PostgrestException catch (e) {
                          if (mounted) {
                            SnackBarWidget.errorSnackBar(context, e.message);
                          }
                        }
                      }
                    },
                    child: const Text('Salvar'),
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
