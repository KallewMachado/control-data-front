import 'package:control_data/app/core/store/register_new_user_store.dart';
import 'package:control_data/app/core/views/forgot_password_page.dart';
import 'package:control_data/app/core/views/verify_otp_page.dart';
import 'package:control_data/app/modules/auth/auth_module.dart';
import 'package:control_data/app/modules/auth/views/auth_store.dart';
import 'package:control_data/app/modules/users/views/change/change_password_page.dart';
import 'package:control_data/app/modules/users/views/users_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/repositories/demands_repository.dart';
import 'core/repositories/user_repository.dart';
import 'core/store/app_store.dart';
import 'modules/demands/views/change/change_demands_page.dart';
import 'modules/demands/views/demands_store.dart';
import 'modules/users/views/change/change_user_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AppStore>(AppStore.new);
    i.addLazySingleton<UsersStore>(UsersStore.new);
    i.addLazySingleton<AuthStore>(AuthStore.new);
    i.addLazySingleton<DemandsStore>(DemandsStore.new);
    i.addLazySingleton<RegisterNewUserStore>(RegisterNewUserStore.new);
    i.add<UserRepository>(UserRepositoryImpl.new);
    i.add<DemandsRepository>(DemandsRepositoryImpl.new);
  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: AuthModule());
    r.child(
      '/changeDemands',
      child: (context) => ChangeDemandsPage(
        demand: r.args.data,
      ),
    );
    r.child(
      '/changeUser',
      child: (context) => ChangeUserPage(
        user: r.args.data,
      ),
    );
    r.child(
      '/changePassword',
      child: (context) => const ChangePasswordPage(
        title: 'Alterar Senha',
      ),
    );
    r.child(
      '/resetPassword',
      child: (context) => const ChangePasswordPage(
        title: 'Nova Senha',
      ),
    );
    r.child(
      '/sendForgot',
      child: (context) => const ForgotPasswordPage(),
    );
    r.child(
      '/verifyOTP',
      child: (context) => VerifyOtpPage(
        email: r.args.queryParams['email']!,
      ),
    );
  }
}
