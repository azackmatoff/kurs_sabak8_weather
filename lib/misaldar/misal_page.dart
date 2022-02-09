import 'dart:developer';

import 'package:flutter/material.dart';

class MisalPage extends StatefulWidget {
  const MisalPage({Key key}) : super(key: key);

  @override
  _MisalPageState createState() => _MisalPageState();
}

class _MisalPageState extends State<MisalPage> {
  /// Asynchronous programming
  /// Future (JS Promise)
  String _name;

  @override
  void initState() {
    super.initState();
    getName();

    log('initState =====>');
  }

  Future<void> getName() async {
    try {
      log('getName =====>');
      await Future.delayed(const Duration(seconds: 2), () {
        log('getName seconds: 2 =====>');
        _name = '2 sekundtan kiyin name keldi';
      });

      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    log('build =====>');
    return Scaffold(
      body: Center(
        child: Text(_name ?? 'Name kele elek'),
      ),
    );
  }
}


/// Postman