import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_flutter/models/todo.dart';
import 'package:todo_flutter/services/firebase_service.dart';
import 'package:todo_flutter/widgets/shimmer/shimmer_loader.dart';

import 'item_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _refreshController = RefreshController();

  final data = ["1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2"];

  late Stream<QuerySnapshot> _todosStream;

  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();

    _todosStream = firebaseService.todosStream();
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: false,
      child: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _todosStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const NativeLoader();
            }

            if (snapshot.hasError) {
              return const NoDataFound(msg: "No todos to show.");
            }

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const NoDataFound(msg: "No todos to show."),
                    FilledButton(
                      onTap: addNewTodo,
                      text: "Create One",
                      margin: p20,
                    ),
                  ],
                );
              }

              todos = docs.map((e) => Todo.fromJson(e.data() as Map<String, dynamic>)).toList();

              return SmartRefresher(
                controller: _refreshController,
                enablePullUp: true,
                header: const ShimmerHeader(
                  text: Text(
                    "Pull To Create Item",
                    style: TextStyle(color: Colors.grey, fontSize: 22),
                  ),
                ),
                child: ListTodosWidget(todos: todos),
                // child: ListView.builder(
                //   itemCount: todos.length,
                //   itemExtent: kToolbarHeight,
                //   itemBuilder: (_, index) {
                //     final todo = todos[index];
                //     return ItemTodo(todo: todo);
                //   },
                // ),
                onRefresh: () async {
                  _refreshController.refreshCompleted();
                  addNewTodo();
                },
                onLoading: () async {},
              );
            }

            return const NoDataFound(msg: "No todos to show.");
          },
        ),
      ),
    );
  }

  void addNewTodo() async {
    showDialog(
      context: context,
      builder: (_) {
        return CreateNewTodoDialog(lastIndex: todos.length);
      },
    );
  }
}

class ListTodosWidget extends StatefulWidget {
  final List<Todo> todos;

  const ListTodosWidget({Key? key, required this.todos}) : super(key: key);

  @override
  _ListTodosWidgetState createState() => _ListTodosWidgetState();
}

class _ListTodosWidgetState extends State<ListTodosWidget> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) => reorderData(oldIndex, newIndex),
      children: [
        for (final todo in widget.todos)
          ItemTodo(
            key: ValueKey(todo.id),
            todo: todo,
          ),
      ],
    );
  }

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = widget.todos.removeAt(oldIndex);
      widget.todos.insert(newIndex, items);
      firebaseService.updateTodo(widget.todos[newIndex].id!, {"index": newIndex});
    });
  }
}

class CreateNewTodoDialog extends StatefulWidget {
  final int lastIndex;

  const CreateNewTodoDialog({Key? key, required this.lastIndex}) : super(key: key);

  @override
  State<CreateNewTodoDialog> createState() => _CreateNewTodoDialogState();
}

class _CreateNewTodoDialogState extends State<CreateNewTodoDialog> {
  final tcTodo = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    tcTodo.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black26,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: tcTodo,
            hasDecoration: false,
            filled: true,
            filledColor: Colors.red[700],
            style: const TextStyle(
              color: Colors.white,
            ),
            actionKeyboard: TextInputAction.done,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19.0),
            onFieldSubmitted: (v) => createNew(),
          ),
          // AlertDialog(
          //   title: const Texts("Create New"),
          //   content: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       TextFormFieldWidget(
          //         controller: tcTodo,
          //       ),
          //     ],
          //   ),
          //   actions: [
          //     FilledButton(
          //       onTap: createNew,
          //       text: "Create One",
          //       margin: p16.copyWith(left: 15, right: 15),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void createNew() async {
    final todo = tcTodo.text.trim();

    if (todo.isEmpty) {
      showErrorToastNotification("Please enter todo to continue!");
      return;
    }

    final index = widget.lastIndex + 1;

    final data = {
      "title": todo,
      "created_at": FieldValue.serverTimestamp(),
      "updated_at": FieldValue.serverTimestamp(),
      "index": index,
    };

    final response = await firebaseService.createNewTodo(data);

    if (response == true) {
      navigationService.back();
    } else {
      showErrorToastNotification("Couldn't add todo please try again later!");
    }
  }
}
