import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:todo_flutter/models/todo.dart';

class ItemTodo extends StatelessWidget {
  final Todo todo;

  const ItemTodo({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red,
            Colors.orange,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: p20.copyWith(top: 0.0, bottom: 0.0),
      child: Texts(
        todo.title!,
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.start,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
