import 'package:contacts/models/user.dart';
import 'package:contacts/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final user = ModalRoute.of(context)?.settings.arguments as User;
      _loadFormData(user);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // final user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Form User'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState?.validate();

                if (isValid!) {
                  _form.currentState?.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                      id: _formData['id'],
                      name: _formData['name'].toString(),
                      email: _formData['email'].toString(),
                      avatarUrl: _formData['avatarUrl'].toString(),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: 'Name:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is invalid';
                    }
                    if (value.trim().length < 3) {
                      return 'Name is too small. Minimal 4 caracters';
                    }

                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: 'Email:'),
                  onSaved: (value) => _formData['email'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'Avatar URL:'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),
              ],
            ),
          ),
        ));
  }
}
