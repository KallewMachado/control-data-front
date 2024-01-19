import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Pages {
  initial(title: 'Inicio'),
  voters(title: 'Usuarios'),
  config(title: 'Configuração');

  const Pages({required this.title});
  final String title;
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;
  Set<Pages> selection = <Pages>{Pages.initial};

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            selection.first.title,
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true),
      body: const RouterOutlet(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SegmentedButton<Pages>(
        showSelectedIcon: false,
        segments: <ButtonSegment<Pages>>[
          ButtonSegment<Pages>(
              value: Pages.initial, label: Text(Pages.initial.title)),
          ButtonSegment<Pages>(
              value: Pages.voters, label: Text(Pages.voters.title)),
          ButtonSegment<Pages>(
              value: Pages.config, label: Text(Pages.config.title)),
        ],
        selected: selection,
        onSelectionChanged: (Set<Pages> newSelection) {
          var router = newSelection.first.name;
          setState(() {
            selection = newSelection;
            Modular.to.navigate('/$router/');
          });
        },
        multiSelectionEnabled: false,
      ),
    );
  }
}
