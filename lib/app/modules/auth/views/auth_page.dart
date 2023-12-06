import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Control Data"),
            const SizedBox(height: 60),
            CustomTextFormWidget(
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            CustomTextFormWidget(
              controller: _passwordController,
              obscureText: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye_sharp),
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(onPressed: () {}, child: const Text("Entrar"))
          ],
        ),
      ),
    );
  }
}
