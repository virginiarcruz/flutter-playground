import 'package:contacts/provider/users.dart';
import 'package:contacts/routes/app_routes.dart';
import 'package:contacts/views/user_form.dart';
import 'package:contacts/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter User List',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          routes: {
            AppRoutes.HOME: (_) => const UserList(),
            AppRoutes.USER_FORM: (_) => UserForm(),
          }),
    );
  }
}
