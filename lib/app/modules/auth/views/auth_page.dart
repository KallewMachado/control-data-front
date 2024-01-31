import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    var theme = Theme.of(context);
    var textColor = theme.colorScheme.primary;
    var text2Color = theme.colorScheme.secondary;
    return Material(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Observer(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style:
                      theme.textTheme.headlineLarge?.copyWith(color: textColor),
                ),
                const SizedBox(height: 60),
                CustomTextFormWidget(
                  label: const Text("E-mail"),
                  controller: _emailController,
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "campo vazio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormWidget(
                  maxlines: 1,
                  label: const Text("senha"),
                  controller: _passwordController,
                  obscureText: _store.obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      _store.changeObscurePassword();
                    },
                    icon: _store.obscurePassword
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.remove),
                  ),
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "campo vazio";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all<Color?>(
                        textColor.withOpacity(0.3)),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        AuthModel auth = AuthModel(
                          id: '',
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        await _store.login(auth);
                        Modular.to.navigate('/home/');
                      } on AuthException catch (e) {
                        print(e.message);
                      }
                    }
                  },
                  child: const Text("Entrar"),
                ),
                TextButton(
                  onPressed: () async {
                    Modular.to.pushNamed('/register');
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: text2Color,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
