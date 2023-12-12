import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _store = Modular.get<AuthStore>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var textColor = Theme.of(context).colorScheme.primary;
    return Material(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Login"),
              const SizedBox(height: 60),
              CustomTextFormWidget(
                label: const Text("Usuario"),
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              CustomTextFormWidget(
                label: const Text("senha"),
                controller: _passwordController,
                obscureText: true,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove_red_eye_sharp),
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color?>(
                      textColor.withOpacity(0.3)),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AuthModel auth = AuthModel(
                      id: '',
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                    _store.login(auth);
                  }
                },
                child: const Text("Entrar"),
              ),
              TextButton(
                onPressed: () async {
                  Modular.to.pushNamed('/register');
                },
                child: const Text(
                  "Register",
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
