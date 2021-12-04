import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      isAppbar: false,
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: FilledButton(
              onTap: () => context.read<AuthProvider>().signInMeAnonymously(),
              margin: p20,
              text: "Sign In Anonymously",
            ),
          )
        ],
      ),
    );
  }
}
