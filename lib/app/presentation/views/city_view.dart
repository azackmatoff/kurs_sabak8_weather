import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kurs_sabak8_weather/app/presentation/widgets/container_with_bg_image.dart';

class CityView extends StatelessWidget {
  CityView({Key key}) : super(key: key);

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Find by city'.toUpperCase()),
        centerTitle: true,
      ),
      body: ContainerWithBgImage(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.orangeAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    hintText: 'Write your city',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                OutlinedButton(
                  onPressed: () {
                    if (_textController.text.isEmpty) {
                      return;
                    }

                    FocusScope.of(context).unfocus();
                    log('textController: ${_textController.text}');

                    Navigator.pop(context, _textController.text);

                    // if (textController.text.isNotEmpty) {
                    //   FocusScope.of(context).unfocus();
                    //   log('textController: ${textController.text}');

                    //   Navigator.pop(context, textController.text);
                    // }
                  },
                  style: outlineButtonStyle,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                    child: Text(
                      'Show weather',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
