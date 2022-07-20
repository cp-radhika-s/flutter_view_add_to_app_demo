import 'package:flutter/material.dart';

import 'data/user.dart';

class UserDetail extends StatelessWidget {
  final User user;
   UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name:  ${user.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Username:  ${user.username}' , style: const TextStyle(fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text('Email:  ${user.email}')
          ],
        ),
      ),
    );
  }
}
