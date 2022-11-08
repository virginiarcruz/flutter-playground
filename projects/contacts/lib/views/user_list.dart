import 'package:contacts/components/user_tile.dart';
import 'package:contacts/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/users.dart';
import '../routes/app_routes.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, i) => UserTile(users.byIndex(i)),
      ),
    );
  }
}
