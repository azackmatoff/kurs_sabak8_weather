import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    this.isLinear = false,
    Key key,
  }) : super(key: key);

  final bool isLinear;

  Widget _buildContent() {
    if (isLinear) {
      return const LinearProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.cyanAccent,
      );
    } else {
      return const CircularProgressIndicator(
        backgroundColor: Colors.white,
        color: Colors.cyanAccent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }
}
