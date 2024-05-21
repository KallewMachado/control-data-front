enum Pages {
  initial(title: 'Inicio'),
  users(title: 'Usuarios'),
  config(title: 'Configuração');

  const Pages({required this.title});
  final String title;
}
