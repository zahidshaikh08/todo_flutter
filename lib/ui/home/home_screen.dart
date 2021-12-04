import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:todo_flutter/services/firebase_service.dart';
import 'package:todo_flutter/widgets/shimmer/shimmer_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _refreshController = RefreshController();

  final data = ["1", "2", "1", "2", "1", "2", "1", "2", "1", "2", "1", "2"];

  late Stream<QuerySnapshot> _todosStream;

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
            final todos = snapshot.data!.docs;

            if (todos.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const NoDataFound(msg: "No todos to show."),
                  FilledButton(
                    onTap: () {},
                    text: "Create One",
                    margin: p20,
                  ),
                ],
              );
            }

            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              header: const ShimmerHeader(
                text: Text(
                  "PullToRefresh",
                  style: TextStyle(color: Colors.grey, fontSize: 22),
                ),
              ),
              child: ListView.builder(
                itemCount: data.length,
                itemExtent: 100.0,
                itemBuilder: (c, i) => const Card(),
              ),
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 2000));
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await Future.delayed(const Duration(milliseconds: 2000));
                for (int i = 0; i < 10; i++) {
                  data.add("1");
                }
                setState(() {});
                _refreshController.loadComplete();
              },
            );
          }

          return const NoDataFound(msg: "No todos to show.");
        },
      )),
    );
  }
}
