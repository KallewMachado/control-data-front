import 'dart:developer' as developer;
import 'package:control_data/app/core/model/demands_model.dart';
import 'package:control_data/app/core/store/app_store.dart';
import 'package:control_data/app/core/views/widgets/snackbar_widget.dart';
import 'package:control_data/app/modules/demands/views/demands_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/views/widgets/custom_dialog_widget.dart';

class CardDemandsWidget extends StatefulWidget {
  const CardDemandsWidget(
      {super.key, required this.demand, required this.store});
  final DemandsModel demand;
  final DemandsStore store;

  @override
  State<CardDemandsWidget> createState() => _CardDemandsWidgetState();
}

class _CardDemandsWidgetState extends State<CardDemandsWidget> {
  final appStore = Modular.get<AppStore>();

  void _deleteDemand() {
    developer.log(
      'run [Delete Demand] ==> ',
      name: 'card_demands_widget.dart',
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        CustomDialogWidet.show(
          context,
          title: (context) =>
              const Text(' Tem certeza que deseja excluir usuario?'),
          content: (context) => const SizedBox(height: 0),
          actions: [
            ElevatedButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Modular.to.pop();
                  await widget.store.removeDemand(widget.demand.id);
                  await widget.store.getAllDemandsByUser(widget.demand.userId);

                  if (mounted) {
                    SnackBarWidget.successSnackBar(
                        context, 'Demanda excluida com sucesso!');
                  }
                } on PostgrestException catch (e) {
                  Modular.to.pop();
                  if (mounted) {
                    SnackBarWidget.errorSnackBar(context, e.message);
                  }
                } catch (e) {
                  Modular.to.pop();
                  if (appStore.hasInternet == false) {
                    if (mounted) {
                      CustomDialogWidet.show(
                        context,
                        content: (context) => const Text(
                            'falha na conexão, verifique sua conexão com a internet e tente novamente'),
                      );
                    }
                  } else {
                    if (mounted) {
                      SnackBarWidget.errorSnackBar(context, e.toString());
                    }
                  }
                }
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _finalize() async {
    try {
      var status = widget.demand.isDone == false ? 'concluida' : 'desfeita';

      var dateDone =
          widget.demand.isDone == false ? DateTime.now().toString() : null;

      Map<String, dynamic> json = {
        "done": !widget.demand.isDone,
        "done_date": dateDone
      };

      await widget.store.updateDemands(json, widget.demand.id);
      await widget.store.getAllDemandsByUser(widget.demand.userId);

      if (mounted) {
        SnackBarWidget.successSnackBar(context, 'Demanda $status com sucesso!');
      }
    } on PostgrestException catch (e) {
      Modular.to.pop();
      if (mounted) {
        SnackBarWidget.errorSnackBar(context, e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.demand.isDone == true ? Colors.green : null,
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        title: Text(widget.demand.title),
        subtitle: Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          widget.demand.description ?? '',
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              onTap: _finalize,
              child: Text(
                  widget.demand.isDone == false ? 'Finalizar' : 'Desfazer'),
            ),
            PopupMenuItem(
              onTap: () {
                Modular.to
                    .pushNamed('/changeDemands', arguments: widget.demand);
              },
              enabled: widget.demand.isDone == true ? false : true,
              child: const Text('Editar'),
            ),
            PopupMenuItem(
              onTap: _deleteDemand,
              enabled: widget.demand.isDone == true ? false : true,
              child: const Text('Remover'),
            ),
          ],
        ),
      ),
    );
  }
}
