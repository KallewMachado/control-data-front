// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer' as developer;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:control_data/app/core/model/auth_model.dart';
import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/core/utils/routes.dart';
import 'package:control_data/app/core/views/widgets/custom_dialog_widget.dart';
import 'package:control_data/app/core/views/widgets/custom_textform_widget.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final AuthStore _store;
  late final AppStore _appStore;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final GlobalKey<FormState> _formKey;

  late StreamSubscription<InternetConnectionStatus> listener;

  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<AuthStore>();
    _appStore = Modular.get<AppStore>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();

    initConnectivity();

    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          developer.log(
            'run [InternetConnectionChecker()] ==> $status',
            name: 'auth_page.dart',
          );
          _appStore.toggleHasInternetStatus(true);

          break;
        case InternetConnectionStatus.disconnected:
          developer.log(
            'run [InternetConnectionChecker()] ==> $status',
            name: 'auth_page.dart',
          );
          _appStore.toggleHasInternetStatus(false);
          CustomDialogWidet.show(
            context,
            content: (context) => const Text(
                'falha na conexão, verifique sua conexão com a internet e tente novamente'),
          );

          break;
      }
    });

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _connectivitySubscription.cancel();
    listener.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = theme.colorScheme.primary;
    var text2Color = theme.colorScheme.secondary;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: SingleChildScrollView(
              child: Observer(
                builder: (context) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: theme.textTheme.headlineLarge
                              ?.copyWith(color: textColor),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Modular.to.pushNamed(routesPath.sendForgot);
                            },
                            child: Text(
                              'Esqueci senha',
                              style: TextStyle(color: text2Color),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        OutlinedButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all<Color?>(
                                textColor.withOpacity(0.3)),
                          ),
                          onPressed: _validation,
                          child: const Text("Entrar"),
                        ),
                        TextButton(
                          onPressed: () async {
                            Modular.to.pushNamed(routesPath.auth.register);
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
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validation() async {
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
                Text('Fazendo login...'),
                SizedBox(height: 10),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
        AuthModel auth = AuthModel(
          id: '',
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        await _store.login(auth);
        Modular.to.navigate(routesPath.auth.home);
      } on AuthException catch (e) {
        Modular.to.pop();
        if (mounted) {
          SnackBarWidget.errorSnackBar(context, e.message);
        }
        if (_appStore.hasInternet == false) {
          if (mounted) {
            CustomDialogWidet.show(
              context,
              content: (context) => const Text(
                  'falha na conexão, verifique sua conexão com a internet e tente novamente'),
            );
          }
        }
      } catch (e) {
        Modular.to.pop();
        if (_appStore.hasInternet == false) {
          if (mounted) {
            CustomDialogWidet.show(
              context,
              content: (context) => const Text(
                  'falha na conexão, verifique sua conexão com a internet e tente novamente'),
            );
          }
        }
      }
    }
  }
}
