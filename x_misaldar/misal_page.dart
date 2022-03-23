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

  Adam _adam1 = Adam(name: 'Jon', age: 32);
  Adam _adam2 = Adam(name: 'Jane', age: 19);

  @override
  void initState() {
    super.initState();

    log('_adam1 name: ${_adam1.name} and age: ${_adam1.age}');
    log('_adam2 name: ${_adam2.name} and age: ${_adam2.age}');

    // getName();
    _getName();

    log('initState =====>');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('didChangeDependencies ===>>');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMyDialog(context);
    });
  }

  @override
  void dispose() {
    log('dispose ===>>');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build =====>');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Misal 2 Page'),
      ),
      body: Center(
        child: Text(_name ?? 'Name kele elek'),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext cntxt) async {
    return showDialog<void>(
      context: cntxt,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getName() {
    _name = '2 sekundtan kiyin name keldi';
    setState(() {});
  }

  Future<void> getName() async {
    try {
      // log('getName =====>');
      await Future.delayed(const Duration(seconds: 2), () {
        // log('getName seconds: 2 =====>');
        _name = '2 sekundtan kiyin name keldi';
      });

      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }
}

/// Postman
///
/// class
/// model
class Adam {
  final String name;
  final int age;

  // Adam({String name, int age}) {
  //   this.name = name;
  //   this.age = age;
  // }

  Adam({this.name, this.age});
}
