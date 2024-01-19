import 'package:flutter/material.dart';

class CardUserWidget extends StatelessWidget {
  const CardUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1.5),
      ),
      leading: Icon(Icons.person),
      title: Text('Name User'),
      subtitle: Text("date Nasc"),
      trailing: Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
