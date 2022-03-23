import 'package:flutter/material.dart';

import 'misal_page.dart';

class Misal2Page extends StatelessWidget {
  const Misal2Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Misal 1 Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MisalPage()));
          },
          child: const Text('Go to next page'),
        ),
      ),
    );
  }
}
